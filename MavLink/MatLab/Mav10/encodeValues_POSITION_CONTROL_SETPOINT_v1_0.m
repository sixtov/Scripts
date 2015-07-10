%%%%  case: 170
function p = encodeValues_POSITION_CONTROL_SETPOINT_v1_0(id,x,y,z,yaw)
	S.id = typecast(uint16(id),'uint16');		% ID of waypoint, 0 for plain position
	S.x = typecast(single(x),'single');		% x position
	S.y = typecast(single(y),'single');		% y position
	S.z = typecast(single(z),'single');		% z position
	S.yaw = typecast(single(yaw),'single');		% yaw orientation in radians, 0 = NORTH
	p = encode_POSITION_CONTROL_SETPOINT_v1_0(S);
return
