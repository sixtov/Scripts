%%%%  case: 123
%%~ data for injecting into the onboard GPS (used for DGPS)
function p = encodeValues_GPS_INJECT_DATA_v1_0(target_system,target_component,len,data)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.len = typecast(uint8(len),'uint8');		% data length
	S.data = typecast(uint8(data),'uint8');		% raw data (110 is enough for 12 satellites of RTCMv2)
	p = encode_GPS_INJECT_DATA_v1_0(S);
return
