%%%%  case: 56
%%~ Set roll, pitch and yaw.
function p = encodeValues_SET_ROLL_PITCH_YAW_THRUST_v1_0(target_system,target_component,roll,pitch,yaw,thrust)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.roll = typecast(single(roll),'single');		% Desired roll angle in radians
	S.pitch = typecast(single(pitch),'single');		% Desired pitch angle in radians
	S.yaw = typecast(single(yaw),'single');		% Desired yaw angle in radians
	S.thrust = typecast(single(thrust),'single');		% Collective thrust, normalized to 0 .. 1
	p = encode_SET_ROLL_PITCH_YAW_THRUST_v1_0(S);
return
