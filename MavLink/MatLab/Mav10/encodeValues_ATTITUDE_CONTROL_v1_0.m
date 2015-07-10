%%%%  case: 200
function p = encodeValues_ATTITUDE_CONTROL_v1_0(target,roll,pitch,yaw,thrust,roll_manual,pitch_manual,yaw_manual,thrust_manual)
	S.target = typecast(uint8(target),'uint8');		% The system to be controlled
	S.roll = typecast(single(roll),'single');		% roll
	S.pitch = typecast(single(pitch),'single');		% pitch
	S.yaw = typecast(single(yaw),'single');		% yaw
	S.thrust = typecast(single(thrust),'single');		% thrust
	S.roll_manual = typecast(uint8(roll_manual),'uint8');		% roll control enabled auto:0, manual:1
	S.pitch_manual = typecast(uint8(pitch_manual),'uint8');		% pitch auto:0, manual:1
	S.yaw_manual = typecast(uint8(yaw_manual),'uint8');		% yaw auto:0, manual:1
	S.thrust_manual = typecast(uint8(thrust_manual),'uint8');		% thrust auto:0, manual:1
	p = encode_ATTITUDE_CONTROL_v1_0(S);
return
