%%%%  case: 82
%%~ Set the vehicle attitude and body angular rates.
function p = encodeValues_SET_ATTITUDE_TARGET_v1_0(time_boot_ms,target_system,target_component,type_mask,q,body_roll_rate,body_pitch_rate,body_yaw_rate,thrust)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp in milliseconds since system boot
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.type_mask = typecast(uint8(type_mask),'uint8');		% Mappings: If any of these bits are set, the corresponding input should be ignored: bit 1: body roll rate, bit 2: body pitch rate, bit 3: body yaw rate. bit 4-bit 6: reserved, bit 7: throttle, bit 8: attitude
	S.q = typecast(single(q),'single');		% Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0)
	S.body_roll_rate = typecast(single(body_roll_rate),'single');		% Body roll rate in radians per second
	S.body_pitch_rate = typecast(single(body_pitch_rate),'single');		% Body roll rate in radians per second
	S.body_yaw_rate = typecast(single(body_yaw_rate),'single');		% Body roll rate in radians per second
	S.thrust = typecast(single(thrust),'single');		% Collective thrust, normalized to 0 .. 1 (-1 .. 1 for vehicles capable of reverse trust)
	p = encode_SET_ATTITUDE_TARGET_v1_0(S);
return
