%%  case: 51
%%~ Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
%%~ and to the GCS.
function S = parse_LOCAL_POSITION_SETPOINT_v1_0(p)
	name = [ ...
		{'coordinate_frame'} ... %% Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
		{'x'}				 ... %% x position
		{'y'}				 ... %% y position
		{'z'}				 ... %% z position
		{'yaw'}				 ... %% Desired yaw angle
		];
	byte = [ 1 4 4 4 4 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

