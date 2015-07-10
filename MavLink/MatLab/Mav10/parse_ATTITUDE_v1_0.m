%%  case: 30
%%~ The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right).
function S = parse_ATTITUDE_v1_0(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'roll'}		 ... %% Roll angle (rad, -pi..+pi)
		{'pitch'}		 ... %% Pitch angle (rad, -pi..+pi)
		{'yaw'}			 ... %% Yaw angle (rad, -pi..+pi)
		{'rollspeed'}	 ... %% Roll angular speed (rad/s)
		{'pitchspeed'}	 ... %% Pitch angular speed (rad/s)
		{'yawspeed'}	 ... %% Yaw angular speed (rad/s)
		];
	byte = [ 4 4 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

