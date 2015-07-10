%%%%  case: 63
%%~ The goal position of the system. This position is the input to any navigation or 
%%~ path planning algorithm and does NOT represent the current controller setpoint.
function p = encodeValues_POSITION_TARGET_v0_9(x,y,z,yaw)
	S.x = typecast(single(x),'single');		% x position
	S.y = typecast(single(y),'single');		% y position
	S.z = typecast(single(z),'single');		% z position
	S.yaw = typecast(single(yaw),'single');		% yaw orientation in radians, 0 = NORTH
	p = encode_POSITION_TARGET_v0_9(S);
return
