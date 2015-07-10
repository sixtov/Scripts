%%%%  case: 44
%%~ This message is emitted as response to WAYPOINT_REQUEST_LIST by the MAV. The GCS 
%%~ can then request the individual waypoints based on the knowledge of the total number 
%%~ of waypoints.
function p = encodeValues_WAYPOINT_COUNT_v0_9(target_system,target_component,count)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.count = typecast(uint16(count),'uint16');		% Number of Waypoints in the Sequence
	p = encode_WAYPOINT_COUNT_v0_9(S);
return
