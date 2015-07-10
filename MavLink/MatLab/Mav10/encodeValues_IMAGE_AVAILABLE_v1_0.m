%%%%  case: 154
function p = encodeValues_IMAGE_AVAILABLE_v1_0(cam_id,cam_no,timestamp,valid_until,img_seq,img_buf_index,width,height,depth,channels,key,exposure,gain,roll,pitch,yaw,local_z,lat,lon,alt,ground_x,ground_y,ground_z)
	S.cam_id = typecast(uint64(cam_id),'uint64');		% Camera id
	S.cam_no = typecast(uint8(cam_no),'uint8');		% Camera # (starts with 0)
	S.timestamp = typecast(uint64(timestamp),'uint64');		% Timestamp
	S.valid_until = typecast(uint64(valid_until),'uint64');		% Until which timestamp this buffer will stay valid
	S.img_seq = typecast(uint32(img_seq),'uint32');		% The image sequence number
	S.img_buf_index = typecast(uint32(img_buf_index),'uint32');		% Position of the image in the buffer, starts with 0
	S.width = typecast(uint16(width),'uint16');		% Image width
	S.height = typecast(uint16(height),'uint16');		% Image height
	S.depth = typecast(uint16(depth),'uint16');		% Image depth
	S.channels = typecast(uint8(channels),'uint8');		% Image channels
	S.key = typecast(uint32(key),'uint32');		% Shared memory area key
	S.exposure = typecast(uint32(exposure),'uint32');		% Exposure time, in microseconds
	S.gain = typecast(single(gain),'single');		% Camera gain
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
	p = encode_IMAGE_AVAILABLE_v1_0(S);
return
