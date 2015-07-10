%%%%  case: 80
%%~ Setpoint in roll, pitch, yaw rates and thrust currently active on the system.
function p = encodeValues_ROLL_PITCH_YAW_RATES_THRUST_SETPOINT_v1_0(time_boot_ms,roll_rate,pitch_rate,yaw_rate,thrust)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp in milliseconds since system boot
	S.roll_rate = typecast(single(roll_rate),'single');		% Desired roll rate in radians per second
	S.pitch_rate = typecast(single(pitch_rate),'single');		% Desired pitch rate in radians per second
	S.yaw_rate = typecast(single(yaw_rate),'single');		% Desired yaw rate in radians per second
	S.thrust = typecast(single(thrust),'single');		% Collective thrust, normalized to 0 .. 1
	p = encode_ROLL_PITCH_YAW_RATES_THRUST_SETPOINT_v1_0(S);
return
