%%%%  case: 176
%%~ Request a current rally point from MAV. MAV should respond with a RALLY_POINT message. 
%%~ MAV should not respond if the request is invalid.
function p = encodeValues_RALLY_FETCH_POINT_v1_0(target_system,target_component,idx)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.idx = typecast(uint8(idx),'uint8');		% point index (first point is 0)
	p = encode_RALLY_FETCH_POINT_v1_0(S);
return
