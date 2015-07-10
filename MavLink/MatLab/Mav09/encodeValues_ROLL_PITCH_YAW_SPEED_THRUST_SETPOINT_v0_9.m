%%%%  case: 58
%%~ Setpoint in rollspeed, pitchspeed, yawspeed currently active on the system.
function p = encodeValues_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_v0_9(time_us,roll_speed,pitch_speed,yaw_speed,thrust)
	S.time_us = typecast(uint64(time_us),'uint64');		% Timestamp in micro seconds since unix epoch
	S.roll_speed = typecast(single(roll_speed),'single');		% Desired roll angular speed in rad/s
	S.pitch_speed = typecast(single(pitch_speed),'single');		% Desired pitch angular speed in rad/s
	S.yaw_speed = typecast(single(yaw_speed),'single');		% Desired yaw angular speed in rad/s
	S.thrust = typecast(single(thrust),'single');		% Collective thrust, normalized to 0 .. 1
	p = encode_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_v0_9(S);
return
