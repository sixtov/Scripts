%%  case: 82
%%~ Set the vehicle attitude and body angular rates.
function S = parse_SET_ATTITUDE_TARGET_v1_0(p)
	name = [ ...
		{'time_boot_ms'}	 ... %% Timestamp in milliseconds since system boot
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'type_mask'}		 ... %% Mappings: If any of these bits are set, the corresponding input should be ignored: bit 1: body roll rate, bit 2: body pitch rate, bit 3: body yaw rate. bit 4-bit 6: reserved, bit 7: throttle, bit 8: attitude
		{'q'}				 ... %% Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0)
		{'body_roll_rate'}	 ... %% Body roll rate in radians per second
		{'body_pitch_rate'}	 ... %% Body roll rate in radians per second
		{'body_yaw_rate'}	 ... %% Body roll rate in radians per second
		{'thrust'}			 ... %% Collective thrust, normalized to 0 .. 1 (-1 .. 1 for vehicles capable of reverse trust)
		];
	byte = [ 4 1 1 1 16 4 4 4 4 ];
	type = [ {'uint32'} {'uint8'} {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

