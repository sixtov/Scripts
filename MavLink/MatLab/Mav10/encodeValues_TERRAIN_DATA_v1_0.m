%%%%  case: 134
%%~ Terrain data sent from GCS. The lat/lon and grid_spacing must be the same as a lat/lon 
%%~ from a TERRAIN_REQUEST
function p = encodeValues_TERRAIN_DATA_v1_0(lat,lon,grid_spacing,gridbit,data)
	S.lat = typecast(int32(lat),'int32');		% Latitude of SW corner of first grid (degrees *10^7)
	S.lon = typecast(int32(lon),'int32');		% Longitude of SW corner of first grid (in degrees *10^7)
	S.grid_spacing = typecast(uint16(grid_spacing),'uint16');		% Grid spacing in meters
	S.gridbit = typecast(uint8(gridbit),'uint8');		% bit within the terrain request mask
	S.data = typecast(int16(data),'int16');		% Terrain data in meters AMSL
	p = encode_TERRAIN_DATA_v1_0(S);
return
