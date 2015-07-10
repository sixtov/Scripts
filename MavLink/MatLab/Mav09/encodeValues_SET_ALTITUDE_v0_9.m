%%%%  case: 65
function p = encodeValues_SET_ALTITUDE_v0_9(target,mode)
	S.target = typecast(uint8(target),'uint8');		% The system setting the altitude
	S.mode = typecast(uint32(mode),'uint32');		% The new altitude in meters
	p = encode_SET_ALTITUDE_v0_9(S);
return
