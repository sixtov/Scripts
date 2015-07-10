%%  case: 136
%%~ Response from a TERRAIN_CHECK request
function S = parse_TERRAIN_REPORT_v1_0(p)
	name = [ ...
		{'lat'}				 ... %% Latitude (degrees *10^7)
		{'lon'}				 ... %% Longitude (degrees *10^7)
		{'spacing'}			 ... %% grid spacing (zero if terrain at this location unavailable)
		{'terrain_height'}	 ... %% Terrain height in meters AMSL
		{'current_height'}	 ... %% Current vehicle height above lat/lon terrain height (meters)
		{'pending'}			 ... %% Number of 4x4 terrain blocks waiting to be received or read from disk
		{'loaded'}			 ... %% Number of 4x4 terrain blocks in memory
		];
	byte = [ 4 4 2 4 4 2 2 ];
	type = [ {'int32'} {'int32'} {'uint16'} {'single'} {'single'} {'uint16'} {'uint16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

