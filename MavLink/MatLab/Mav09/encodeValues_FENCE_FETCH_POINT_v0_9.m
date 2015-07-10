%%%%  case: 161
%%~ Request a current fence point from MAV
function p = encodeValues_FENCE_FETCH_POINT_v0_9(target_system,target_component,idx)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.idx = typecast(uint8(idx),'uint8');		% point index (first point is 1, 0 is for return point)
	p = encode_FENCE_FETCH_POINT_v0_9(S);
return
