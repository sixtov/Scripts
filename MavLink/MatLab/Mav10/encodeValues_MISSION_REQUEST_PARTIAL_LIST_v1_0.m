%%%%  case: 37
%%~ Request a partial list of mission items from the system/component. http://qgroundcontrol.org/mavlink/waypoint_protocol. 
%%~ If start and end index are the same, just 
%%~ send one waypoint.
function p = encodeValues_MISSION_REQUEST_PARTIAL_LIST_v1_0(target_system,target_component,start_index,end_index)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.start_index = typecast(int16(start_index),'int16');		% Start index, 0 by default
	S.end_index = typecast(int16(end_index),'int16');		% End index, -1 by default (-1: send list to end). Else a valid index of the list
	p = encode_MISSION_REQUEST_PARTIAL_LIST_v1_0(S);
return
