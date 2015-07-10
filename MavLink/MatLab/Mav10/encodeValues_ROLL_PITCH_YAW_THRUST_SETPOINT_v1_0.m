%%%%  case: 58
%%~ Setpoint in roll, pitch, yaw currently active on the system.
function p = encodeValues_ROLL_PITCH_YAW_THRUST_SETPOINT_v1_0(time_boot_ms,roll,pitch,yaw,thrust)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp in milliseconds since system boot
	S.roll = typecast(single(roll),'single');		% Desired roll angle in radians
	S.pitch = typecast(single(pitch),'single');		% Desired pitch angle in radians
	S.yaw = typecast(single(yaw),'single');		% Desired yaw angle in radians
	S.thrust = typecast(single(thrust),'single');		% Collective thrust, normalized to 0 .. 1
	p = encode_ROLL_PITCH_YAW_THRUST_SETPOINT_v1_0(S);
return
