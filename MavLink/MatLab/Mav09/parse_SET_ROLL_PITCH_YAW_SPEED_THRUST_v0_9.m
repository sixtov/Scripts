%%  case: 56
%%~ Set roll, pitch and yaw.
function S = parse_SET_ROLL_PITCH_YAW_SPEED_THRUST_v0_9(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'roll_speed'}		 ... %% Desired roll angular speed in rad/s
		{'pitch_speed'}		 ... %% Desired pitch angular speed in rad/s
		{'yaw_speed'}		 ... %% Desired yaw angular speed in rad/s
		{'thrust'}			 ... %% Collective thrust, normalized to 0 .. 1
		];
	byte = [ 1 1 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

