%%%%  case: 41
%%~ Set the waypoint with sequence number seq as current waypoint. This means that the 
%%~ MAV will continue to this waypoint on the shortest path (not following the waypoints 
%%~ in-between).
function p = encodeValues_WAYPOINT_SET_CURRENT_v0_9(target_system,target_component,seq)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.seq = typecast(uint16(seq),'uint16');		% Sequence
	p = encode_WAYPOINT_SET_CURRENT_v0_9(S);
return
