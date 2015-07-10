%%%%  case: 152
function p = encodeValues_IMAGE_TRIGGERED_v1_0(timestamp,seq,roll,pitch,yaw,local_z,lat,lon,alt,ground_x,ground_y,ground_z)
	S.timestamp = typecast(uint64(timestamp),'uint64');		% Timestamp
	S.seq = typecast(uint32(seq),'uint32');		% IMU seq
	S.roll = typecast(single(roll),'single');		% Roll angle in rad
	S.pitch = typecast(single(pitch),'single');		% Pitch angle in rad
	S.yaw = typecast(single(yaw),'single');		% Yaw angle in rad
	S.local_z = typecast(single(local_z),'single');		% Local frame Z coordinate (height over ground)
	S.lat = typecast(single(lat),'single');		% GPS X coordinate
	S.lon = typecast(single(lon),'single');		% GPS Y coordinate
	S.alt = typecast(single(alt),'single');		% Global frame altitude
	S.ground_x = typecast(single(ground_x),'single');		% Ground truth X
	S.ground_y = typecast(single(ground_y),'single');		% Ground truth Y
	S.ground_z = typecast(single(ground_z),'single');		% Ground truth Z
	p = encode_IMAGE_TRIGGERED_v1_0(S);
return
