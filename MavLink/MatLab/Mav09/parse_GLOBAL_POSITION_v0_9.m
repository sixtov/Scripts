%%  case: 33
%%~ The filtered global position (e.g. fused GPS and accelerometers). Coordinate frame 
%%~ is right-handed, Z-axis up (GPS frame)
function S = parse_GLOBAL_POSITION_v0_9(p)
	name = [ ...
		{'usec'} ... %% Timestamp (microseconds since unix epoch)
		{'lat'}	 ... %% Latitude, in degrees
		{'lon'}	 ... %% Longitude, in degrees
		{'alt'}	 ... %% Absolute altitude, in meters
		{'vx'}	 ... %% X Speed (in Latitude direction, positive: going north)
		{'vy'}	 ... %% Y Speed (in Longitude direction, positive: going east)
		{'vz'}	 ... %% Z Speed (in Altitude direction, positive: going up)
		];
	byte = [ 8 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

