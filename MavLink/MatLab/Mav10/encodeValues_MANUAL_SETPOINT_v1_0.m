%%%%  case: 81
%%~ Setpoint in roll, pitch, yaw and thrust from the operator
function p = encodeValues_MANUAL_SETPOINT_v1_0(time_boot_ms,roll,pitch,yaw,thrust,mode_switch,manual_override_switch)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp in milliseconds since system boot
	S.roll = typecast(single(roll),'single');		% Desired roll rate in radians per second
	S.pitch = typecast(single(pitch),'single');		% Desired pitch rate in radians per second
	S.yaw = typecast(single(yaw),'single');		% Desired yaw rate in radians per second
	S.thrust = typecast(single(thrust),'single');		% Collective thrust, normalized to 0 .. 1
	S.mode_switch = typecast(uint8(mode_switch),'uint8');		% Flight mode switch position, 0.. 255
	S.manual_override_switch = typecast(uint8(manual_override_switch),'uint8');		% Override mode switch position, 0.. 255
	p = encode_MANUAL_SETPOINT_v1_0(S);
return
