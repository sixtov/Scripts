%%%%  case: 102
function p = encodeValues_VISION_POSITION_ESTIMATE_v1_0(usec,x,y,z,roll,pitch,yaw)
	S.usec = typecast(uint64(usec),'uint64');		% Timestamp (microseconds, synced to UNIX time or since system boot)
	S.x = typecast(single(x),'single');		% Global X position
	S.y = typecast(single(y),'single');		% Global Y position
	S.z = typecast(single(z),'single');		% Global Z position
	S.roll = typecast(single(roll),'single');		% Roll angle in rad
	S.pitch = typecast(single(pitch),'single');		% Pitch angle in rad
	S.yaw = typecast(single(yaw),'single');		% Yaw angle in rad
	p = encode_VISION_POSITION_ESTIMATE_v1_0(S);
return
