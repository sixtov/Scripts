%%  case: 63
%%~ The goal position of the system. This position is the input to any navigation or 
%%~ path planning algorithm and does NOT represent the current controller setpoint.
function S = parse_POSITION_TARGET_v0_9(p)
	name = [ ...
		{'x'}	 ... %% x position
		{'y'}	 ... %% y position
		{'z'}	 ... %% z position
		{'yaw'}	 ... %% yaw orientation in radians, 0 = NORTH
		];
	byte = [ 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

