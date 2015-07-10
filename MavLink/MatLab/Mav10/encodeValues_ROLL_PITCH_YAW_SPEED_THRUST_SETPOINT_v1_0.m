%%%%  case: 59
%%~ Setpoint in rollspeed, pitchspeed, yawspeed currently active on the system.
function p = encodeValues_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_v1_0(time_boot_ms,roll_speed,pitch_speed,yaw_speed,thrust)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp in milliseconds since system boot
	S.roll_speed = typecast(single(roll_speed),'single');		% Desired roll angular speed in rad/s
	S.pitch_speed = typecast(single(pitch_speed),'single');		% Desired pitch angular speed in rad/s
	S.yaw_speed = typecast(single(yaw_speed),'single');		% Desired yaw angular speed in rad/s
	S.thrust = typecast(single(thrust),'single');		% Collective thrust, normalized to 0 .. 1
	p = encode_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_v1_0(S);
return
