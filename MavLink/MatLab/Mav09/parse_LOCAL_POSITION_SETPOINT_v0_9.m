%%  case: 51
%%~ Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
%%~ and to the GCS.
function S = parse_LOCAL_POSITION_SETPOINT_v0_9(p)
	name = [ ...
		{'x'}	 ... %% x position
		{'y'}	 ... %% y position
		{'z'}	 ... %% z position
		{'yaw'}	 ... %% Desired yaw angle
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

