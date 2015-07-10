%%%%  case: 136
%%~ Response from a TERRAIN_CHECK request
function p = encodeValues_TERRAIN_REPORT_v1_0(lat,lon,spacing,terrain_height,current_height,pending,loaded)
	S.lat = typecast(int32(lat),'int32');		% Latitude (degrees *10^7)
	S.lon = typecast(int32(lon),'int32');		% Longitude (degrees *10^7)
	S.spacing = typecast(uint16(spacing),'uint16');		% grid spacing (zero if terrain at this location unavailable)
	S.terrain_height = typecast(single(terrain_height),'single');		% Terrain height in meters AMSL
	S.current_height = typecast(single(current_height),'single');		% Current vehicle height above lat/lon terrain height (meters)
	S.pending = typecast(uint16(pending),'uint16');		% Number of 4x4 terrain blocks waiting to be received or read from disk
	S.loaded = typecast(uint16(loaded),'uint16');		% Number of 4x4 terrain blocks in memory
	p = encode_TERRAIN_REPORT_v1_0(S);
return
