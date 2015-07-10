%%%%  case: 56
%%~ Set roll, pitch and yaw.
function p = encodeValues_SET_ROLL_PITCH_YAW_SPEED_THRUST_v0_9(target_system,target_component,roll_speed,pitch_speed,yaw_speed,thrust)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.roll_speed = typecast(single(roll_speed),'single');		% Desired roll angular speed in rad/s
	S.pitch_speed = typecast(single(pitch_speed),'single');		% Desired pitch angular speed in rad/s
	S.yaw_speed = typecast(single(yaw_speed),'single');		% Desired yaw angular speed in rad/s
	S.thrust = typecast(single(thrust),'single');		% Collective thrust, normalized to 0 .. 1
	p = encode_SET_ROLL_PITCH_YAW_SPEED_THRUST_v0_9(S);
return
