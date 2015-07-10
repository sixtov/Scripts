%%%%  case: 171
function p = encodeValues_MARKER_v1_0(id,x,y,z,roll,pitch,yaw)
	S.id = typecast(uint16(id),'uint16');		% ID
	S.x = typecast(single(x),'single');		% x position
	S.y = typecast(single(y),'single');		% y position
	S.z = typecast(single(z),'single');		% z position
	S.roll = typecast(single(roll),'single');		% roll orientation
	S.pitch = typecast(single(pitch),'single');		% pitch orientation
	S.yaw = typecast(single(yaw),'single');		% yaw orientation
	p = encode_MARKER_v1_0(S);
return
