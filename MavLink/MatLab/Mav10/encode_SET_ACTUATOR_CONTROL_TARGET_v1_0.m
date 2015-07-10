%%  case: 139
%%~ Set the vehicle attitude and body angular rates.
function p = encode_SET_ACTUATOR_CONTROL_TARGET_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(43);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(139);
	name = [ ...
		{'time_usec'}		 ... %% Timestamp (micros since boot or Unix epoch)
		{'group_mlx'}		 ... %% Actuator group. The "_mlx" indicates this is a multi-instance message and a MAVLink parser should use this field to difference between instances.
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'controls'}		 ... %% Actuator controls. Normed to -1..+1 where 0 is neutral position. Throttle for single rotation direction motors is 0..1, negative range for reverse direction. Standard mapping for attitude controls (group 0): (index 0-7): roll, pitch, yaw, throttle, flaps, spoilers, airbrakes, landing gear. Load a pass-through mixer to repurpose them as generic outputs.
		];
	byte = [ 8 1 1 1 32 ];
	type = [ {'uint64'} {'uint8'} {'uint8'} {'uint8'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_usec data field
	val = typecast(S.time_usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode group_mlx data field
	val = typecast(S.group_mlx,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode controls data field
	val = typecast(S.controls,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
