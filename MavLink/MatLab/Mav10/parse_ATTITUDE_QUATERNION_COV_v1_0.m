%%  case: 61
%%~ The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), 
%%~ expressed as quaternion. Quaternion order is w, x, y, z and a zero rotation would 
%%~ be expressed as (1 0 0 0).
function S = parse_ATTITUDE_QUATERNION_COV_v1_0(p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'q'}			 ... %% Quaternion components, w, x, y, z (1 0 0 0 is the null-rotation)
		{'rollspeed'}	 ... %% Roll angular speed (rad/s)
		{'pitchspeed'}	 ... %% Pitch angular speed (rad/s)
		{'yawspeed'}	 ... %% Yaw angular speed (rad/s)
		{'covariance'}	 ... %% Attitude covariance
		];
	byte = [ 4 16 4 4 4 36 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

