%%  case: 134
%%~ Terrain data sent from GCS. The lat/lon and grid_spacing must be the same as a lat/lon 
%%~ from a TERRAIN_REQUEST
function S = parse_TERRAIN_DATA_v1_0(p)
	name = [ ...
		{'lat'}			 ... %% Latitude of SW corner of first grid (degrees *10^7)
		{'lon'}			 ... %% Longitude of SW corner of first grid (in degrees *10^7)
		{'grid_spacing'} ... %% Grid spacing in meters
		{'gridbit'}		 ... %% bit within the terrain request mask
		{'data'}		 ... %% Terrain data in meters AMSL
		];
	byte = [ 4 4 2 1 32 ];
	type = [ {'int32'} {'int32'} {'uint16'} {'uint8'} {'int16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

