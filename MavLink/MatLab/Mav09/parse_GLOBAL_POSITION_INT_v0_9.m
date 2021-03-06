%%  case: 73
%%~ The filtered global position (e.g. fused GPS and accelerometers). The position is 
%%~ in GPS-frame (right-handed, Z-up)
function S = parse_GLOBAL_POSITION_INT_v0_9(p)
	name = [ ...
		{'lat'}	 ... %% Latitude, expressed as * 1E7
		{'lon'}	 ... %% Longitude, expressed as * 1E7
		{'alt'}	 ... %% Altitude in meters, expressed as * 1000 (millimeters)
		{'vx'}	 ... %% Ground X Speed (Latitude), expressed as m/s * 100
		{'vy'}	 ... %% Ground Y Speed (Longitude), expressed as m/s * 100
		{'vz'}	 ... %% Ground Z Speed (Altitude), expressed as m/s * 100
		];
	byte = [ 4 4 4 2 2 2 ];
	type = [ {'int32'} {'int32'} {'int32'} {'int16'} {'int16'} {'int16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

