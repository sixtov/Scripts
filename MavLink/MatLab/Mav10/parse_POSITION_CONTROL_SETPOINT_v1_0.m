%%  case: 170
function S = parse_POSITION_CONTROL_SETPOINT_v1_0(p)
	name = [ ...
		{'id'}	 ... %% ID of waypoint, 0 for plain position
		{'x'}	 ... %% x position
		{'y'}	 ... %% y position
		{'z'}	 ... %% z position
		{'yaw'}	 ... %% yaw orientation in radians, 0 = NORTH
		];
	byte = [ 2 4 4 4 4 ];
	type = [ {'uint16'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

