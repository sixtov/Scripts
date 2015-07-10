%%  case: 135
%%~ Request that the vehicle report terrain height at the given location. Used by GCS 
%%~ to check if vehicle has all terrain data needed for a mission.
function S = parse_TERRAIN_CHECK_v1_0(p)
	name = [ ...
		{'lat'}	 ... %% Latitude (degrees *10^7)
		{'lon'}	 ... %% Longitude (degrees *10^7)
		];
	byte = [ 4 4 ];
	type = [ {'int32'} {'int32'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

