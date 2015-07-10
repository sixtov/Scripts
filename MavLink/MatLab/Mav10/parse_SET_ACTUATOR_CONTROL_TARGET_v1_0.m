%%  case: 139
%%~ Set the vehicle attitude and body angular rates.
function S = parse_SET_ACTUATOR_CONTROL_TARGET_v1_0(p)
	name = [ ...
		{'time_usec'}		 ... %% Timestamp (micros since boot or Unix epoch)
		{'group_mlx'}		 ... %% Actuator group. The "_mlx" indicates this is a multi-instance message and a MAVLink parser should use this field to difference between instances.
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'controls'}		 ... %% Actuator controls. Normed to -1..+1 where 0 is neutral position. Throttle for single rotation direction motors is 0..1, negative range for reverse direction. Standard mapping for attitude controls (group 0): (index 0-7): roll, pitch, yaw, throttle, flaps, spoilers, airbrakes, landing gear. Load a pass-through mixer to repurpose them as generic outputs.
		];
	byte = [ 8 1 1 1 32 ];
	type = [ {'uint64'} {'uint8'} {'uint8'} {'uint8'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

