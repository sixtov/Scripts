%%  case: 58
%%~ Setpoint in roll, pitch, yaw currently active on the system.
function S = parse_ROLL_PITCH_YAW_THRUST_SETPOINT(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp in milliseconds since system boot
		{'roll'}		 ... %% Desired roll angle in radians
		{'pitch'}		 ... %% Desired pitch angle in radians
		{'yaw'}			 ... %% Desired yaw angle in radians
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

