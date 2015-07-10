%%  case: 160
%%~ A fence point. Used to set a point when from        GCS -> MAV. Also used to return 
%%~ a point from MAV -> GCS
function S = parse_FENCE_POINT_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'idx'}				 ... %% point index (first point is 1, 0 is for return point)
		{'count'}			 ... %% total number of points (for sanity checking)
		{'lat'}				 ... %% Latitude of point
		{'lng'}				 ... %% Longitude of point
		];
	byte = [ 1 1 1 1 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

