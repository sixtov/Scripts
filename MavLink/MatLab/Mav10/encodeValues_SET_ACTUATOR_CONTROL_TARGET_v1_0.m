%%%%  case: 139
%%~ Set the vehicle attitude and body angular rates.
function p = encodeValues_SET_ACTUATOR_CONTROL_TARGET_v1_0(time_usec,group_mlx,target_system,target_component,controls)
	S.time_usec = typecast(uint64(time_usec),'uint64');		% Timestamp (micros since boot or Unix epoch)
	S.group_mlx = typecast(uint8(group_mlx),'uint8');		% Actuator group. The "_mlx" indicates this is a multi-instance message and a MAVLink parser should use this field to difference between instances.
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.controls = typecast(single(controls),'single');		% Actuator controls. Normed to -1..+1 where 0 is neutral position. Throttle for single rotation direction motors is 0..1, negative range for reverse direction. Standard mapping for attitude controls (group 0): (index 0-7): roll, pitch, yaw, throttle, flaps, spoilers, airbrakes, landing gear. Load a pass-through mixer to repurpose them as generic outputs.
	p = encode_SET_ACTUATOR_CONTROL_TARGET_v1_0(S);
return
