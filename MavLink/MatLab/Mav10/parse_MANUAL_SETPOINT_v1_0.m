%%  case: 81
%%~ Setpoint in roll, pitch, yaw and thrust from the operator
function S = parse_MANUAL_SETPOINT_v1_0(p)
	name = [ ...
		{'time_boot_ms'}			 ... %% Timestamp in milliseconds since system boot
		{'roll'}					 ... %% Desired roll rate in radians per second
		{'pitch'}					 ... %% Desired pitch rate in radians per second
		{'yaw'}						 ... %% Desired yaw rate in radians per second
		{'thrust'}					 ... %% Collective thrust, normalized to 0 .. 1
		{'mode_switch'}				 ... %% Flight mode switch position, 0.. 255
		{'manual_override_switch'}	 ... %% Override mode switch position, 0.. 255
		];
	byte = [ 4 4 4 4 4 1 1 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

