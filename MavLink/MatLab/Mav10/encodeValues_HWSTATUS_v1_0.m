%%%%  case: 165
%%~ Status of key hardware
function p = encodeValues_HWSTATUS_v1_0(Vcc,I2Cerr)
	S.Vcc = typecast(uint16(Vcc),'uint16');		% board voltage (mV)
	S.I2Cerr = typecast(uint8(I2Cerr),'uint8');		% I2C error count
	p = encode_HWSTATUS_v1_0(S);
return
