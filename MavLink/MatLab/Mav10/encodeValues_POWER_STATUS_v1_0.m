%%%%  case: 125
%%~ Power supply status
function p = encodeValues_POWER_STATUS_v1_0(Vcc,Vservo,flags)
	S.Vcc = typecast(uint16(Vcc),'uint16');		% 5V rail voltage in millivolts
	S.Vservo = typecast(uint16(Vservo),'uint16');		% servo rail voltage in millivolts
	S.flags = typecast(uint16(flags),'uint16');		% power supply status flags (see MAV_POWER_STATUS enum)
	p = encode_POWER_STATUS_v1_0(S);
return
