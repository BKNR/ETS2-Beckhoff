CoDeSys+#   �                   @        @   2.3.10.0    @?    @                                     �Q�S +    @                           k�iO        �   @   q   C:\TWINCAT\PLC\LIB\STANDARD.LIB @                                                                                          CONCAT               STR1               ��              STR2               ��                 CONCAT                                         *!�S  �   ����           CTD           M             ��           Variable for CD Edge Detection      CD            ��           Count Down on rising edge    LOAD            ��           Load Start Value    PV           ��           Start Value       Q            ��           Counter reached 0    CV           ��           Current Counter Value             *!�S  �   ����           CTU           M             ��            Variable for CU Edge Detection       CU            ��       
    Count Up    RESET            ��           Reset Counter to 0    PV           ��           Counter Limit       Q            ��           Counter reached the Limit    CV           ��           Current Counter Value             *!�S  �   ����           CTUD           MU             ��            Variable for CU Edge Detection    MD             ��            Variable for CD Edge Detection       CU            ��	       
    Count Up    CD            ��
           Count Down    RESET            ��           Reset Counter to Null    LOAD            ��           Load Start Value    PV           ��           Start Value / Counter Limit       QU            ��           Counter reached Limit    QD            ��           Counter reached Null    CV           ��           Current Counter Value             *!�S  �   ����           DELETE               STR               ��              LEN           ��              POS           ��                 DELETE                                         *!�S  �   ����           F_TRIG           M             ��
                 CLK            ��           Signal to detect       Q            ��           Edge detected             *!�S  �   ����           FIND               STR1               ��              STR2               ��                 FIND                                     *!�S  �   ����           INSERT               STR1               ��              STR2               ��              POS           ��                 INSERT                                         *!�S  �   ����           LEFT               STR               ��              SIZE           ��                 LEFT                                         *!�S  �   ����           LEN               STR               ��                 LEN                                     *!�S  �   ����           MID               STR               ��              LEN           ��              POS           ��                 MID                                         *!�S  �   ����           R_TRIG           M             ��
                 CLK            ��           Signal to detect       Q            ��           Edge detected             *!�S  �   ����           REPLACE               STR1               ��              STR2               ��              L           ��              P           ��                 REPLACE                                         *!�S  �   ����           RIGHT               STR               ��              SIZE           ��                 RIGHT                                         *!�S  �   ����           RS               SET            ��              RESET1            ��                 Q1            ��
                       *!�S  �   ����           SEMA           X             ��                 CLAIM            ��	              RELEASE            ��
                 BUSY            ��                       *!�S  �   ����           SR               SET1            ��              RESET            ��                 Q1            ��	                       *!�S  �   ����           TOF           M             ��           internal variable 	   StartTime            ��           internal variable       IN            ��       ?    starts timer with falling edge, resets timer with rising edge    PT           ��           time to pass, before Q is set       Q            ��	       2    is FALSE, PT seconds after IN had a falling edge    ET           ��
           elapsed time             *!�S  �   ����           TON           M             ��           internal variable 	   StartTime            ��           internal variable       IN            ��       ?    starts timer with rising edge, resets timer with falling edge    PT           ��           time to pass, before Q is set       Q            ��	       0    is TRUE, PT seconds after IN had a rising edge    ET           ��
           elapsed time             *!�S  �   ����           TP        	   StartTime            ��           internal variable       IN            ��       !    Trigger for Start of the Signal    PT           ��       '    The length of the High-Signal in 10ms       Q            ��	           The pulse    ET           ��
       &    The current phase of the High-Signal             *!�S  �   ����    R    @                                                                                          CALCULATIONS           FLcalc                            FRcalc                            BLBcalc                            BRBcalc                            LongLat                            apu1              	              apu2              
                               *!�S  @    ����           CALCULATIONS_BACKUP           P             "                                *!�S  @    ����           F_ANALOGOUTPUT               fOutput            !            Output value 
   fMinOutput            !            Scaling minimum value 
   fMaxOutput            !            Scaling maximum value 	   nMinValue           !            Maximum analog value 	   nMaxValue           !            Maximum analog value       F_AnalogOutput                                     *!�S  @    ����           MAIN           M0                 SR                    M1                 SR                    M2                 RS                    M3                 RS                    M4                 RS                    M5                 RS                                     �&�S  @    ����            
 �      !   	   ����       ����         "   (       K   #     K   1     K   ?     K   T                 a         +     ��localhost }ژ	v   ��    pT�H }`}H��X8}l� $� � H� �w��| ����w/�w.�w��           ��          ����� x,�w�����     ��� � �{�� �� ����    `��d�             X� ��          ��       �p� ��R����� �p� �R����� ��     ,   ,                                                        K         @   *!�S6  /*BECKCONFI3*/
        !
SV? @   @   �   �     3               
   Standard            	�Q�S     isuniobl           VAR_GLOBAL
END_VAR
                                                                                  "   , � � �             Standard
         MAIN����           ���� �Q�S                 $����,     �               ATSACFUI           Standard k�iO	k�iO        ?Tke                         	�Q�S     ucsflyFA           VAR_CONFIG
END_VAR
                                                                                   '              , C�            Global_Variables �Q�S	�Q�S     teti. ru        �  VAR_GLOBAL
	(*Digital Inputs*)
	bStart AT  %I* :BOOL;
	bStandby AT %I* :BOOL;
	bEmergencyButton AT %I*: BOOL;
	bEmergencyConfirm AT %I*: BOOL;

	(*Digital outputs*)
	bStartLight AT  %Q* :BOOL;
	bStopLight AT %Q* :BOOL;
	bStandbyLight AT %Q* :BOOL;
	bEmergencyLight AT %Q*: BOOL;
	bStartupPower AT %Q*: BOOL;
	bBackup1 AT %Q* :BOOL;
	bBackup2 AT %Q* :BOOL;
	bBackup3 AT %Q* :BOOL;

	(*Analog inputs*)
	rAccelerationX AT %I* :INT;
	rAccelerationY AT %I* :INT;
	rAccelerationZ AT %I* :INT;
	rAnaloginputBackup AT %I* :INT;

	(*Analog Outputs*)
	iCylinderFL AT %Q* :INT;
	iCylinderFR AT %Q* :INT;
	iCylinderBLF AT %Q* :INT;
	iCylinderBLB AT %Q* :INT;
	iCylinderBRF AT %Q* :INT;
	iCylinderBRB AT %Q* :INT;
	iAnalogoutBackup1 AT %Q* :INT;
	iAnalogoutBackup2 AT %Q* :INT;

(*		Drawing of pneumatic cylinders in simulator
  
                                      FL/        \FR
		------------------------------------------
		|		Ambulace 		|
		|		Front			|
		|						|
		|						|
		|						|
		|						|
BLF	        /|						|\	BRF
	      /  |						|  \
	      \  |						|  /
	        \|						|/
BLB		|		rear				|	BRB
		|________________________|
		

*)
	(*Program variables*)


	FromADS:ARRAY [0..8] OF REAL;

	(*From Game*)
	LatAcc :REAL;
	LongAcc :REAL;
	HorizontalAcc:REAL;

	(*Not presently used*)
	Pitch:REAL;
	Roll:REAL;
	Speed:REAL;
	RPM:REAL;

	(*Testing for min-max values*)
	MaxX :REAL;
	MaxY:REAL;
	MaxZ:REAL;
	MinX :REAL;
	MinY:REAL;
	MinZ:REAL;


	(*Kirjota jotain fiksua*)
	rMultiplyerLatAcc:REAL;
	rMultiplyerLongAcc:REAL;
	rMultiplyerZAcc:REAL;
	rMultiplyerForce:REAL;
	rForceDirection:REAL;
	rCylinderFLCalc:REAL;
	rCylinderFRCalc:REAL;
	rCylinderBLFCalc:REAL;
	rCylinderBLBCalc:REAL;
	rCylinderBRFCalc:REAL;
	rCylinderBRBCalc:REAL;
	bEmergyStop_OK:BOOL;
	rpi: REAL;
	bEmergencyValvomo: BOOL;
	bStandbyValvomo: BOOL;
	bStandbyInternal: BOOL;
	bStartValvomo: BOOL;
	bStartInternal: BOOL;
	bEmergencyFeedback: BOOL;
END_VAR
                                                                                               '              , � � q�           TwinCAT_Configuration *!�S	�Q�S                     �  (* Generated automatically by TwinCAT - (read only) *)
VAR_CONFIG
	.bStart AT %IX8.0 : BOOL;	(*  ~ {LinkedWith:TIID^Device 2 (EtherCAT)^Term 1 (EK1101)^Term 2 (EL1008)^Channel 3^Input} *)
	.bStandby AT %IX8.1 : BOOL;	(*  ~ {LinkedWith:TIID^Device 2 (EtherCAT)^Term 1 (EK1101)^Term 2 (EL1008)^Channel 4^Input} *)
	.bEmergencyButton AT %IX12.0 : BOOL;
	.bEmergencyConfirm AT %IX12.1 : BOOL;	(*  ~ {LinkedWith:TIID^Device 2 (EtherCAT)^Term 1 (EK1101)^Term 2 (EL1008)^Channel 2^Input} *)
	.bStartLight AT %QX16.0 : BOOL;	(*  ~ {LinkedWith:TIID^Device 2 (EtherCAT)^Term 1 (EK1101)^Term 3 (EL2008)^Channel 2^Output} *)
	.bStopLight AT %QX16.1 : BOOL;
	.bStandbyLight AT %QX16.2 : BOOL;	(*  ~ {LinkedWith:TIID^Device 2 (EtherCAT)^Term 1 (EK1101)^Term 3 (EL2008)^Channel 3^Output} *)
	.bEmergencyLight AT %QX20.0 : BOOL;	(*  ~ {LinkedWith:TIID^Device 2 (EtherCAT)^Term 1 (EK1101)^Term 3 (EL2008)^Channel 1^Output} *)
	.bStartupPower AT %QX20.1 : BOOL;	(*  ~ {LinkedWith:TIID^Device 2 (EtherCAT)^Term 1 (EK1101)^Term 3 (EL2008)^Channel 8^Output} *)
	.bBackup1 AT %QX16.5 : BOOL;
	.bBackup2 AT %QX16.6 : BOOL;
	.bBackup3 AT %QX16.7 : BOOL;
	.rAccelerationX AT %IB0 : INT;
	.rAccelerationY AT %IB2 : INT;
	.rAccelerationZ AT %IB4 : INT;
	.rAnaloginputBackup AT %IB6 : INT;
	.iCylinderFL AT %QB0 : INT;	(*  ~ {LinkedWith:TIID^Device 2 (EtherCAT)^Term 1 (EK1101)^Term 5 (EL4124)^AO Output Channel 3^Analog output} *)
	.iCylinderFR AT %QB2 : INT;	(*  ~ {LinkedWith:TIID^Device 2 (EtherCAT)^Term 1 (EK1101)^Term 5 (EL4124)^AO Output Channel 4^Analog output} *)
	.iCylinderBLF AT %QB4 : INT;	(*  ~ {LinkedWith:TIID^Device 2 (EtherCAT)^Term 1 (EK1101)^Term 5 (EL4124)^AO Output Channel 2^Analog output} *)
	.iCylinderBLB AT %QB6 : INT;	(*  ~ {LinkedWith:TIID^Device 2 (EtherCAT)^Term 1 (EK1101)^Term 5 (EL4124)^AO Output Channel 1^Analog output} *)
	.iCylinderBRF AT %QB8 : INT;	(*  ~ {LinkedWith:TIID^Device 2 (EtherCAT)^Term 1 (EK1101)^Term 6 (EL4124)^AO Output Channel 1^Analog output} *)
	.iCylinderBRB AT %QB10 : INT;	(*  ~ {LinkedWith:TIID^Device 2 (EtherCAT)^Term 1 (EK1101)^Term 6 (EL4124)^AO Output Channel 2^Analog output} *)
	.iAnalogoutBackup1 AT %QB12 : INT;
	.iAnalogoutBackup2 AT %QB14 : INT;
END_VAR                                                                                               '           	   , K K _           Variable_Configuration *!�S	*!�S	     teti fma           VAR_CONFIG
END_VAR
                                                                                                 �   |0|0 @v    @T   MS Sans Serif @       HH':'mm':'ss   dd'-'MM'-'yyyy   dd'-'MM'-'yyyy HH':'mm':'ss�����                               .     �   ���  �3 ���   � ���     
    @��  ���     @      DEFAULT             System      �   |0|0 @v    @T   MS Sans Serif @       HH':'mm':'ss   dd'-'MM'-'yyyy   dd'-'MM'-'yyyy HH':'mm':'ss�����                      )   HH':'mm':'ss @                             dd'-'MM'-'yyyy @        '               , � # q/           Calculations *!�S	*!�S      S�~�4          �   PROGRAM Calculations
VAR

	FLcalc: REAL;
	FRcalc:REAL;
	BLBcalc: REAL;
	BRBcalc: REAL;
	LongLat: REAL;
	apu1: REAL;
	apu2: REAL;
END_VAR�  (*(*pi*)


(*Force calculations*)
IF LatAcc<>0 AND LongAcc<>0
THEN
MultiplyerForce:=SQRT(LatAcc*LatAcc+LongAcc*LongAcc);
END_IF;
(*direction calculations. First Exception*)
IF LatAcc=0
THEN
	IF  LongAcc>0
	THEN
	ForceDirection:=pi;
	ELSE
	ForceDirection:=0;
	END_IF;
ELSIF LongAcc=0
THEN
	IF  LatAcc>0
	THEN
	ForceDirection:=3/2*pi;
	ELSE
	ForceDirection:=pi/2;
	END_IF;
ELSE
LongLat:=LongAcc/LatAcc;
(*Direction calculations. Normal*)
	IF LongAcc>0 AND LatAcc>0
	THEN
	apu1:=ATAN(LongLat);
	apu2:=1.5*pi;
	ForceDirection:=apu2-apu1;

	ELSIF LongAcc<0 AND LatAcc>0
	THEN
	ForceDirection:=2*pi+ATAN(LongLat);

	ELSIF LongAcc<0 AND LatAcc<0
	THEN
	ForceDirection:=pi*0.5-ATAN(LongLat);

	ELSE
	ForceDirection:=pi+ATAN(LongLat);
	END_IF;
END_IF;
(*Cylinder output calculations*)
FLcalc:=ForceDirection;
FRcalc:=ForceDirection+(0.5*pi);
BLBcalc:=ForceDirection+(1.5*pi);
BRBcalc:=ForceDirection+pi;
CylinderFLCalc:=LIMIT(0,MultiplyerForce*SIN(FLcalc)+50+HorizontalAcc,100);
CylinderFRCalc:=LIMIT(0,MultiplyerForce*SIN(FRcalc)+50+HorizontalAcc,100);
(*CylinderBLFCalc:=LIMIT(0,MultiplyerForce*SIN(ForceDirection+2822)+50+HorizontalAcc,100);*)
CylinderBLBCalc:=LIMIT(0,MultiplyerForce*SIN(BLBcalc)+50+HorizontalAcc,100);
(*CylinderBRFCalc:=LIMIT(0,MultiplyerForce*SIN(ForceDirection+66566)+50+HorizontalAcc,100);*)
CylinderBRBCalc:=LIMIT(0,MultiplyerForce*SIN(BRBcalc)+50+HorizontalAcc,100);
(*nousee k��nt�ess� oikealle*)
*)


rpi:=3.141592654;               "   , ���v�           Calculations_Backup F�S	*!�S      unr  P
        6   
PROGRAM Calculations_Backup
VAR
	P: BOOL;
END_VAR�  rMultiplyerLongAcc:=2;
rMultiplyerLatAcc:=3;
rMultiplyerZAcc:=2;

LatAcc := FromADS[0];
HorizontalAcc := FromADS[1];
LongAcc := FromADS[2];

(*Testing with min-max values*)

MinX := FromADS[3];
MaxX := FromADS[4];
MinY := FromADS[5];
MaxY := FromADS[6];
MinZ := FromADS[7];
MaxZ := FromADS[8];

Pitch := 0;
Roll := 0;
Speed := 0;
RPM :=0;;
(* These are unused no, maybe will add them later
Pitch := FromADS[3];
Roll := FromADS[4];
Speed := FromADS[5];
RPM :=FromADS[6];
*)

rCylinderFLCalc:=LIMIT(20,rMultiplyerLongAcc*LongAcc-rMultiplyerLatAcc*LatAcc+rMultiplyerZAcc*HorizontalAcc+50,80);
rCylinderFRCalc:=LIMIT(20,rMultiplyerLongAcc*LongAcc+rMultiplyerLatAcc*LatAcc+rMultiplyerZAcc*HorizontalAcc+50,80);
rCylinderBLFCalc:=LIMIT(20,rMultiplyerZAcc*HorizontalAcc-rMultiplyerLongAcc*LongAcc*0.9-rMultiplyerLatAcc*LatAcc+50,80);
rCylinderBLBCalc:=LIMIT(20,rMultiplyerZAcc*HorizontalAcc-rMultiplyerLongAcc*LongAcc-rMultiplyerLatAcc*LatAcc+50,80);
rCylinderBRFCalc:=LIMIT(20,(rMultiplyerZAcc*HorizontalAcc-rMultiplyerLongAcc*LongAcc*0.9+rMultiplyerLatAcc*LatAcc+50),80);
rCylinderBRBCalc:=LIMIT(20,(rMultiplyerZAcc*HorizontalAcc-rMultiplyerLongAcc*LongAcc+rMultiplyerLatAcc*LatAcc+50),80);
               !   , d d &x           F_AnalogOutput *!�S	*!�S      rFceINor          FUNCTION F_AnalogOutput : INT
VAR_INPUT
	fOutput: REAL; (* Output value *)
	fMinOutput:REAL; (* Scaling minimum value *)
	fMaxOutput:REAL; (* Scaling maximum value *)
	nMinValue: INT;  (* Maximum analog value *)
	nMaxValue: INT;  (* Maximum analog value *)
END_VAR
VAR
END_VARK  IF fOutput > fMaxOutput THEN
	fOutput := fMaxOutput;
ELSIF  fOutput < fMinOutput THEN
	fOutput := fMinOutput;
ELSIF  (fOutput >= fMinOutput) AND (fOutput <= fMaxOutput) THEN
	fOutput:= fOutput;
END_IF;

F_AnalogOutput := REAL_TO_INT((nMaxValue - nMinValue) * (fOutput - fMinOutput) / (fMaxOutput - fMinOutput) + nMinValue);                   , S �%           MAIN �&�S	�&�S       ��          V   PROGRAM MAIN
VAR
	M0: SR;
	M1: SR;
	M2: RS;
	M3: RS;
	M4: RS;
	M5: RS;
END_VAR      M0bEmergencyButtonAbEmergencyValvomoORAbEmergencyConfirmSR        bEmergencyFeedback bEmergencyLight     1AbStartupPowerXOR  bEmergencyLight     M4bStartupPowerAbStartInternalRS        bStartLight     M5bStartInternalAbStandbyInternalRS        bStandbyLight     M1bEmergencyConfirmAbEmergencyLightSR        bStartupPower     M2bStandbyAbStandbyValvomoORBbStartbStartValvomobEmergencyButtonAbEmergencyLightORRS        bStandbyInternal     M3bStartAbStartValvomoORBbStandbybStandbyValvomobEmergencyButtonAbEmergencyLightORRS        bStartInternal     bEmergencyLightbStartInternal25ArCylinderFLCalcSELA0SEL01000A20000F_AnalogOutput  iCylinderFL     bEmergencyLightbStartInternal25ArCylinderFRCalcSELA0SEL01000A20000F_AnalogOutput  iCylinderFR     bEmergencyLightbStartInternal25ArCylinderBLFCalcSELA0SEL01000A20000F_AnalogOutput  iCylinderBLF     bEmergencyLightbStartInternal25ArCylinderBLBCalcSELA0SEL01000A20000F_AnalogOutput  iCylinderBLB     bEmergencyLightbStartInternal25ArCylinderBRFCalcSELA0SEL01000A20000F_AnalogOutput  iCylinderBRF     bEmergencyLightbStartInternal25ArCylinderBRBCalcSELA0SEL01000A20000F_AnalogOutput  iCylinderBRB     ???�Calculations_Backup      d                    ����, 2 2 ��         "   STANDARD.LIB 5.6.98 12:03:02 @F�w5      CONCAT @                	   CTD @        	   CTU @        
   CTUD @           DELETE @           F_TRIG @        
   FIND @           INSERT @        
   LEFT @        	   LEN @        	   MID @           R_TRIG @           REPLACE @           RIGHT @           RS @        
   SEMA @           SR @        	   TOF @        	   TON @           TP @              Global Variables 0 @                        , � � ��           2                ����������������  
             ����  anie sar        ����, � � ��                      POUs            	   Functions                 F_AnalogOutput  !   ����                Calculations                    Calculations_Backup  "                   MAIN      ����          
   Data types  ����             Visualizations  ����              Global Variables                Global_Variables                     TwinCAT_Configuration                     Variable_Configuration  	   ����                                                              k�iO                         	   localhost            P      	   localhost            P      	   localhost            P           �Tn�