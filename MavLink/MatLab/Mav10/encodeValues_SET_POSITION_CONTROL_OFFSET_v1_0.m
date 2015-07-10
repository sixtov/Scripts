%%%%  case: 160
%%~ Message sent to the MAV to set a new offset from the currently controlled position
function p = encodeValues_SET_POSITION_CONTROL_OFFSET_v1_0(target_system,target_component,x,y,z,yaw)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.x = typecast(single(x),'single');		% x position offset
	S.y = typecast(single(y),'single');		% y position offset
	S.z = typecast(single(z),'single');		% z position offset
	S.yaw = typecast(single(yaw),'single');		% yaw orientation offset in radians, 0 = NORTH
	p = encode_SET_POSITION_CONTROL_OFFSET_v1_0(S);
return
