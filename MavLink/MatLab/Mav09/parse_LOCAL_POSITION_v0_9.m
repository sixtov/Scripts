%%  case: 31
%%~ The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
%%~ frame is right-handed, Z-axis down (aeronautical frame)
function S = parse_LOCAL_POSITION_v0_9(p)
	name = [ ...
		{'usec'} ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'x'}	 ... %% X Position
		{'y'}	 ... %% Y Position
		{'z'}	 ... %% Z Position
		{'vx'}	 ... %% X Speed
		{'vy'}	 ... %% Y Speed
		{'vz'}	 ... %% Z Speed
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

