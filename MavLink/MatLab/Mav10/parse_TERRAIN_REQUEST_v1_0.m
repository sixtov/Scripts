%%  case: 133
%%~ Request for terrain data and terrain status
function S = parse_TERRAIN_REQUEST_v1_0(p)
	name = [ ...
		{'lat'}			 ... %% Latitude of SW corner of first grid (degrees *10^7)
		{'lon'}			 ... %% Longitude of SW corner of first grid (in degrees *10^7)
		{'grid_spacing'} ... %% Grid spacing in meters
		{'mask'}		 ... %% Bitmask of requested 4x4 grids (row major 8x7 array of grids, 56 bits)
		];
	byte = [ 4 4 2 8 ];
	type = [ {'int32'} {'int32'} {'uint16'} {'uint64'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

