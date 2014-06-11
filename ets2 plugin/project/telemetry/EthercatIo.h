#ifndef ETHERCATIO_H
#define ETHERCATIO_H

#include <Windows.h>

#include "C:\TwinCAT\AdsApi\TcAdsDll\Include\TcAdsDef.h"
#include "C:\TwinCAT\AdsApi\TcAdsDll\Include\TcAdsApi.h"

class EthercatIo {
public:
	EthercatIo::EthercatIo();

    void WriteDataToPlc(float *data, ULONG lengthOfVectorAsBytes);
    void ReadDataFromPlc(float *data, ULONG lengthOfVectorAsBytes);
    void CloseConnection();
    bool failInInitializing; //t�ll� voit tarkastaa release tilassa, ett� alustus onnistui
private:
    void InitializeConnection(); //used in the constructor
    long		nErr, nPort;
    AmsAddr		Addr;
    PAmsAddr	pAddr;
    DWORD		dwData;
    ULONG		hInputs;
    ULONG		hOutputs;
};

#endif
