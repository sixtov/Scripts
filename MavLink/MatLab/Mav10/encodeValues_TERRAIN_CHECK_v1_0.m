%%%%  case: 135
%%~ Request that the vehicle report terrain height at the given location. Used by GCS 
%%~ to check if vehicle has all terrain data needed for a mission.
function p = encodeValues_TERRAIN_CHECK_v1_0(lat,lon)
	S.lat = typecast(int32(lat),'int32');		% Latitude (degrees *10^7)
	S.lon = typecast(int32(lon),'int32');		% Longitude (degrees *10^7)
	p = encode_TERRAIN_CHECK_v1_0(S);
return
