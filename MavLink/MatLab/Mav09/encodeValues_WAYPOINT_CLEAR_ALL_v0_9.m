%%%%  case: 45
%%~ Delete all waypoints at once.
function p = encodeValues_WAYPOINT_CLEAR_ALL_v0_9(target_system,target_component)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	p = encode_WAYPOINT_CLEAR_ALL_v0_9(S);
return
