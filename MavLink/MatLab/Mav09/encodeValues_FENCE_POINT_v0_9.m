%%%%  case: 160
%%~ A fence point. Used to set a point when from        GCS -> MAV. Also used to return 
%%~ a point from MAV -> GCS
function p = encodeValues_FENCE_POINT_v0_9(target_system,target_component,idx,count,lat,lng)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.idx = typecast(uint8(idx),'uint8');		% point index (first point is 1, 0 is for return point)
	S.count = typecast(uint8(count),'uint8');		% total number of points (for sanity checking)
	S.lat = typecast(single(lat),'single');		% Latitude of point
	S.lng = typecast(single(lng),'single');		% Longitude of point
	p = encode_FENCE_POINT_v0_9(S);
return
