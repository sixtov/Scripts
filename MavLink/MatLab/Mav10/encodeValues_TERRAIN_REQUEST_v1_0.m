%%%%  case: 133
%%~ Request for terrain data and terrain status
function p = encodeValues_TERRAIN_REQUEST_v1_0(lat,lon,grid_spacing,mask)
	S.lat = typecast(int32(lat),'int32');		% Latitude of SW corner of first grid (degrees *10^7)
	S.lon = typecast(int32(lon),'int32');		% Longitude of SW corner of first grid (in degrees *10^7)
	S.grid_spacing = typecast(uint16(grid_spacing),'uint16');		% Grid spacing in meters
	S.mask = typecast(uint64(mask),'uint64');		% Bitmask of requested 4x4 grids (row major 8x7 array of grids, 56 bits)
	p = encode_TERRAIN_REQUEST_v1_0(S);
return
