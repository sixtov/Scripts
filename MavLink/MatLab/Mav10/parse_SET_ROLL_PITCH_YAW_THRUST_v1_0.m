%%  case: 56
%%~ Set roll, pitch and yaw.
function S = parse_SET_ROLL_PITCH_YAW_THRUST_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'roll'}			 ... %% Desired roll angle in radians
		{'pitch'}			 ... %% Desired pitch angle in radians
		{'yaw'}				 ... %% Desired yaw angle in radians
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

