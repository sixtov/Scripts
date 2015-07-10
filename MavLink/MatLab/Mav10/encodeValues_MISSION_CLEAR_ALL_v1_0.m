%%%%  case: 45
%%~ Delete all mission items at once.
function p = encodeValues_MISSION_CLEAR_ALL_v1_0(target_system,target_component)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	p = encode_MISSION_CLEAR_ALL_v1_0(S);
return
