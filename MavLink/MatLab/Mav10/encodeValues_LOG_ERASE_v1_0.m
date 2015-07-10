%%%%  case: 121
%%~ Erase all logs
function p = encodeValues_LOG_ERASE_v1_0(target_system,target_component)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	p = encode_LOG_ERASE_v1_0(S);
return
