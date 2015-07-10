%%%%  case: 100
%%~ Optical flow from a flow sensor (e.g. optical mouse sensor)
function p = encodeValues_OPTICAL_FLOW_v0_9(time,sensor_id,flow_x,flow_y,quality,ground_distance)
	S.time = typecast(uint64(time),'uint64');		% Timestamp (UNIX)
	S.sensor_id = typecast(uint8(sensor_id),'uint8');		% Sensor ID
	S.flow_x = typecast(int16(flow_x),'int16');		% Flow in pixels in x-sensor direction
	S.flow_y = typecast(int16(flow_y),'int16');		% Flow in pixels in y-sensor direction
	S.quality = typecast(uint8(quality),'uint8');		% Optical flow quality / confidence. 0: bad, 255: maximum quality
	S.ground_distance = typecast(single(ground_distance),'single');		% Ground distance in meters
	p = encode_OPTICAL_FLOW_v0_9(S);
return
