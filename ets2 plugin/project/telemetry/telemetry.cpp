/**
 * @brief ETS2 plugin that sends data via UDP
 *
 * Sends the telemetry data to UDP socket that connects to server at SERVER:PORT
 */

// Windows stuff.

#define WINVER 0x0500
#define _WIN32_WINNT 0x0500
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdarg.h>

// SDK

#include "scssdk_telemetry.h"
#include "eurotrucks2/scssdk_eut2.h"
#include "eurotrucks2/scssdk_telemetry_eut2.h"

#define UNUSED(x)

// Ethercat for PLC comminunication

#include "EthercatIo.h"

/**
 * @brief Tracking of paused state of the game.
 */
bool output_paused = true;

/**
 * @brief Last timestamp we received.
 */
scs_timestamp_t last_timestamp = static_cast<scs_timestamp_t>(-1);

/**
 * @brief Combined telemetry data.
 */
struct telemetry_state_t
{
	scs_timestamp_t timestamp;
	scs_timestamp_t raw_rendering_timestamp;
	scs_timestamp_t raw_simulation_timestamp;
	scs_timestamp_t raw_paused_simulation_timestamp;

	bool	orientation_available;
	float	heading;
	float	pitch;
	float	roll;

	float	accelX;
	float	accelY;
	float	accelZ;

	float	speed;
} telemetry;

/**
 * @brief Function writing message to the game internal log.
 */
scs_log_t game_log = NULL;

/**
* @brief EthercatIO object
*/
EthercatIo* eth = 0;

/**
* @brief Data to send to the PLC
*/
float dataToPLC[3];

/**
* @brief Frame counter to limit the sending of data to PLC
*/
int frames;



// Handling of individual events.

SCSAPI_VOID telemetry_frame_start(const scs_event_t UNUSED(event), const void *const event_info, const scs_context_t UNUSED(context))
{
	const struct scs_telemetry_frame_start_t *const info = static_cast<const scs_telemetry_frame_start_t *>(event_info);

	// The following processing of the timestamps is done so the output
	// from this plugin has continuous time, it is not necessary otherwise.

	// When we just initialized itself, assume that the time started
	// just now.

	if (last_timestamp == static_cast<scs_timestamp_t>(-1)) {
		last_timestamp = info->paused_simulation_time;
	}

	// The timer might be sometimes restarted (e.g. after load) while
	// we want to provide continuous time on our output.

	if (info->flags & SCS_TELEMETRY_FRAME_START_FLAG_timer_restart) {
		last_timestamp = 0;
	}

	// Advance the timestamp by delta since last frame.

	telemetry.timestamp += (info->paused_simulation_time - last_timestamp);
	last_timestamp = info->paused_simulation_time;

	// The raw values.

	telemetry.raw_rendering_timestamp = info->render_time;
	telemetry.raw_simulation_timestamp = info->simulation_time;
	telemetry.raw_paused_simulation_timestamp = info->paused_simulation_time;
}

SCSAPI_VOID telemetry_frame_end(const scs_event_t UNUSED(event), const void *const UNUSED(event_info), const scs_context_t UNUSED(context))
{
	if (output_paused) {
		return;
	}

	frames++;
	if (frames == 10) {
		frames = 0;
		dataToPLC[0] = telemetry.accelX;
		dataToPLC[1] = telemetry.accelY;
		dataToPLC[2] = telemetry.accelZ;
		eth->WriteDataToPlc(dataToPLC, sizeof(dataToPLC));
	}

	// This is were you do the things you want with the telemetry
}

SCSAPI_VOID telemetry_pause(const scs_event_t event, const void *const UNUSED(event_info), const scs_context_t UNUSED(context))
{
	output_paused = (event == SCS_TELEMETRY_EVENT_paused);
}

SCSAPI_VOID telemetry_configuration(const scs_event_t event, const void *const event_info, const scs_context_t UNUSED(context))
{
	// It's possible to init stuff here
	
	eth = new EthercatIo();
	frames = 0;
}

// Handling of individual channels.

SCSAPI_VOID telemetry_store_orientation(const scs_string_t name, const scs_u32_t index, const scs_value_t *const value, const scs_context_t context)
{
	assert(context);
	telemetry_state_t *const state = static_cast<telemetry_state_t *>(context);

	// This callback was registered with the SCS_TELEMETRY_CHANNEL_FLAG_no_value flag
	// so it is called even when the value is not available.

	if (! value) {
		state->orientation_available = false;
		return;
	}

	assert(value);
	assert(value->type == SCS_VALUE_TYPE_euler);
	state->orientation_available = true;
	state->heading = value->value_euler.heading * 360.0f;
	state->pitch = value->value_euler.pitch * 360.0f;
	state->roll = value->value_euler.roll * 360.0f;
}


SCSAPI_VOID telemetry_store_acceleration(const scs_string_t name, const scs_u32_t index, const scs_value_t *const value, const scs_context_t context)
{
	assert(context);
	telemetry_state_t *const state = static_cast<telemetry_state_t *>(context);

	// This callback was registered with the SCS_TELEMETRY_CHANNEL_FLAG_no_value flag
	// so it is called even when the value is not available.

	assert(value);
	assert(value->type == SCS_VALUE_TYPE_fvector);
	state->accelX = value->value_fvector.x;
	state->accelY = value->value_fvector.y;
	state->accelZ = value->value_fvector.z;
}

SCSAPI_VOID telemetry_store_float(const scs_string_t name, const scs_u32_t index, const scs_value_t *const value, const scs_context_t context)
{
	// The SCS_TELEMETRY_CHANNEL_FLAG_no_value flag was not provided during registration
	// so this callback is only called when a valid value is available.

	assert(value);
	assert(value->type == SCS_VALUE_TYPE_float);
	assert(context);
	*static_cast<float *>(context) = value->value_float.value;
}

/**
 * @brief Telemetry API initialization function.
 *
 * See scssdk_telemetry.h
 */
SCSAPI_RESULT scs_telemetry_init(const scs_u32_t version, const scs_telemetry_init_params_t *const params)
{
	// We currently support only one version.

	if (version != SCS_TELEMETRY_VERSION_1_00) {
		return SCS_RESULT_unsupported;
	}

	const scs_telemetry_init_params_v100_t *const version_params = static_cast<const scs_telemetry_init_params_v100_t *>(params);

	// Register for events. Note that failure to register those basic events
	// likely indicates invalid usage of the api or some critical problem. As the
	// example requires all of them, we can not continue if the registration fails.

	const bool events_registered =
		(version_params->register_for_event(SCS_TELEMETRY_EVENT_frame_start, telemetry_frame_start, NULL) == SCS_RESULT_ok) &&
		(version_params->register_for_event(SCS_TELEMETRY_EVENT_frame_end, telemetry_frame_end, NULL) == SCS_RESULT_ok) &&
		(version_params->register_for_event(SCS_TELEMETRY_EVENT_paused, telemetry_pause, NULL) == SCS_RESULT_ok) &&
		(version_params->register_for_event(SCS_TELEMETRY_EVENT_started, telemetry_pause, NULL) == SCS_RESULT_ok)
	;
	if (! events_registered) {

		// Registrations created by unsuccessfull initialization are
		// cleared automatically so we can simply exit.

		version_params->common.log(SCS_LOG_TYPE_error, "Unable to register event callbacks");
		return SCS_RESULT_generic_error;
	}

	// Register for the configuration info. As this example only prints the retrieved
	// data, it can operate even if that fails.

	version_params->register_for_event(SCS_TELEMETRY_EVENT_configuration, telemetry_configuration, NULL);

	// Register for channels. The channel might be missing if the game does not support
	// it (SCS_RESULT_not_found) or if does not support the requested type
	// (SCS_RESULT_unsupported_type). For purpose of this example we ignore the failues
	// so the unsupported channels will remain at theirs default value.

	version_params->register_for_channel(SCS_TELEMETRY_TRUCK_CHANNEL_world_placement, SCS_U32_NIL, SCS_VALUE_TYPE_euler, SCS_TELEMETRY_CHANNEL_FLAG_no_value, telemetry_store_orientation, &telemetry);
	version_params->register_for_channel(SCS_TELEMETRY_TRUCK_CHANNEL_local_linear_acceleration, SCS_U32_NIL, SCS_VALUE_TYPE_fvector, SCS_TELEMETRY_CHANNEL_FLAG_none, telemetry_store_acceleration, &telemetry);
	version_params->register_for_channel(SCS_TELEMETRY_TRUCK_CHANNEL_speed, SCS_U32_NIL, SCS_VALUE_TYPE_float, SCS_TELEMETRY_CHANNEL_FLAG_no_value, telemetry_store_float, &telemetry.speed);

	// Remember the function we will use for logging.

	game_log = version_params->common.log;
	game_log(SCS_LOG_TYPE_message, "Initializing telemetry log example");

	// Set the structure with defaults.

	memset(&telemetry, 0, sizeof(telemetry));
	last_timestamp = static_cast<scs_timestamp_t>(-1);

	// Initially the game is paused.

	output_paused = true;
	return SCS_RESULT_ok;
}

/**
 * @brief Telemetry API deinitialization function.
 *
 * See scssdk_telemetry.h
 */
SCSAPI_VOID scs_telemetry_shutdown(void)
{
	// Any cleanup needed. The registrations will be removed automatically
	// so there is no need to do that manually.

	eth->CloseConnection();
	delete eth;
	game_log = NULL;
}

// Telemetry api.

BOOL APIENTRY DllMain(HMODULE module, DWORD reason_for_call, LPVOID reseved)
{
	if (reason_for_call == DLL_PROCESS_DETACH) {
		//here we can do stuff if something weird happens and we have to bail out
	}
	return TRUE;
}