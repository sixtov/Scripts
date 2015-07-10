%%%%  case: 175
%%~ A rally point. Used to set a point when from GCS -> MAV. Also used to return a point 
%%~ from MAV -> GCS
function p = encodeValues_RALLY_POINT_v1_0(target_system,target_component,idx,count,lat,lng,alt,break_alt,land_dir,flags)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.idx = typecast(uint8(idx),'uint8');		% point index (first point is 0)
	S.count = typecast(uint8(count),'uint8');		% total number of points (for sanity checking)
	S.lat = typecast(int32(lat),'int32');		% Latitude of point in degrees * 1E7
	S.lng = typecast(int32(lng),'int32');		% Longitude of point in degrees * 1E7
	S.alt = typecast(int16(alt),'int16');		% Transit / loiter altitude in meters relative to home
	S.break_alt = typecast(int16(break_alt),'int16');		% Break altitude in meters relative to home
	S.land_dir = typecast(uint16(land_dir),'uint16');		% Heading to aim for when landing. In centi-degrees.
	S.flags = typecast(uint8(flags),'uint8');		% See RALLY_FLAGS enum for definition of the bitmask.
	p = encode_RALLY_POINT_v1_0(S);
return
