#include "EthercatIo.h"
#include <iostream>


EthercatIo::EthercatIo() {
	EthercatIo::InitializeConnection();
}

void EthercatIo::InitializeConnection() {
    pAddr = &Addr;
    nPort = AdsPortOpen();
    
	nErr = AdsGetLocalAddress(pAddr);
	if (nErr) {
		std::cerr << "Error: AdsGetLocalAddress: " << nErr << '\n';
		failInInitializing = true;
	}

    pAddr->port = 801;

    //10.112.98.1.1.1 netId local in lepuski
    pAddr->netId.b[0]=10;
    pAddr->netId.b[1]=112;
    pAddr->netId.b[2]=98;
    pAddr->netId.b[3]=1;
    pAddr->netId.b[4]=1;
    pAddr->netId.b[5]=1;

	// Creating handles to variables
    nErr=AdsSyncReadWriteReq(pAddr, ADSIGRP_SYM_HNDBYNAME, 0x0, sizeof(ULONG), &hInputs, sizeof(".FromADS"),".FromADS");
    if(nErr) {
		std::cerr << "Error: AdsSyncReadWriteReq: " << nErr << '\n';
		failInInitializing=true;
	}

    nErr=AdsSyncReadWriteReq(pAddr, ADSIGRP_SYM_HNDBYNAME, 0x0, sizeof(ULONG), &hOutputs, sizeof(".FromADS"),".FromADS");
    if(nErr) {
		std::cerr << "Error: AdsSyncReadWriteReq: " << nErr << '\n';
		failInInitializing=true;
	} 
}

void EthercatIo::WriteDataToPlc(float *data, ULONG lengthOfVectorAsBytes) {
    nErr=AdsSyncWriteReq(pAddr, ADSIGRP_SYM_VALBYHND, hOutputs,lengthOfVectorAsBytes, data);

}

//luku logiikalta
void EthercatIo::ReadDataFromPlc(float *data, ULONG lengthOfVectorAsBytes) {
    nErr=AdsSyncReadReq(pAddr, ADSIGRP_SYM_VALBYHND, hInputs, lengthOfVectorAsBytes, data);
}

void EthercatIo::CloseConnection() {
      nErr=AdsSyncWriteReq(pAddr, ADSIGRP_SYM_RELEASEHND, 0x0, sizeof(ULONG), &hInputs);
      nErr=AdsSyncWriteReq(pAddr, ADSIGRP_SYM_RELEASEHND, 0x0, sizeof(ULONG), &hOutputs);
}