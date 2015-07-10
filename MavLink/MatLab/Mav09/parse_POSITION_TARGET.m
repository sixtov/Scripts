%%  case: 63
%%~ The goal position of the system. This position is the input to any navigation or 
%%~ path planning algorithm and does NOT represent the current controller setpoint.
function S = parse_POSITION_TARGET(S,p)
	name = [ ...
		{'x'}	 ... %% x position
		{'y'}	 ... %% y position
		{'z'}	 ... %% z position
		{'yaw'}	 ... %% yaw orientation in radians, 0 = NORTH
		];
	byte = [ 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

