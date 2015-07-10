%%%%  case: 57
%%~ Setpoint in roll, pitch, yaw currently active on the system.
function p = encodeValues_ROLL_PITCH_YAW_THRUST_SETPOINT_v0_9(time_us,roll,pitch,yaw,thrust)
	S.time_us = typecast(uint64(time_us),'uint64');		% Timestamp in micro seconds since unix epoch
	S.roll = typecast(single(roll),'single');		% Desired roll angle in radians
	S.pitch = typecast(single(pitch),'single');		% Desired pitch angle in radians
	S.yaw = typecast(single(yaw),'single');		% Desired yaw angle in radians
	S.thrust = typecast(single(thrust),'single');		% Collective thrust, normalized to 0 .. 1
	p = encode_ROLL_PITCH_YAW_THRUST_SETPOINT_v0_9(S);
return
