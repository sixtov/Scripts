%%  case: 31
%%~ The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), 
%%~ expressed as quaternion. Quaternion order is w, x, y, z and a zero rotation would 
%%~ be expressed as (1 0 0 0).
function S = parse_ATTITUDE_QUATERNION_v1_0(p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'q1'}			 ... %% Quaternion component 1, w (1 in null-rotation)
		{'q2'}			 ... %% Quaternion component 2, x (0 in null-rotation)
		{'q3'}			 ... %% Quaternion component 3, y (0 in null-rotation)
		{'q4'}			 ... %% Quaternion component 4, z (0 in null-rotation)
		{'rollspeed'}	 ... %% Roll angular speed (rad/s)
		{'pitchspeed'}	 ... %% Pitch angular speed (rad/s)
		{'yawspeed'}	 ... %% Yaw angular speed (rad/s)
		];
	byte = [ 4 4 4 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

