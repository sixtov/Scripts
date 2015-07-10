%%  case: 59
%%~ Setpoint in rollspeed, pitchspeed, yawspeed currently active on the system.
function S = parse_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp in milliseconds since system boot
		{'roll_speed'}	 ... %% Desired roll angular speed in rad/s
		{'pitch_speed'}	 ... %% Desired pitch angular speed in rad/s
		{'yaw_speed'}	 ... %% Desired yaw angular speed in rad/s
		{'thrust'}		 ... %% Collective thrust, normalized to 0 .. 1
		];
	byte = [ 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

