%%  case: 58
%%~ Setpoint in rollspeed, pitchspeed, yawspeed currently active on the system.
function S = parse_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_v0_9(p)
	name = [ ...
		{'time_us'}		 ... %% Timestamp in micro seconds since unix epoch
		{'roll_speed'}	 ... %% Desired roll angular speed in rad/s
		{'pitch_speed'}	 ... %% Desired pitch angular speed in rad/s
		{'yaw_speed'}	 ... %% Desired yaw angular speed in rad/s
		{'thrust'}		 ... %% Collective thrust, normalized to 0 .. 1
		];
	byte = [ 8 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

