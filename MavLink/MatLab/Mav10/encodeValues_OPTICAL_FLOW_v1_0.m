%%%%  case: 100
%%~ Optical flow from a flow sensor (e.g. optical mouse sensor)
function p = encodeValues_OPTICAL_FLOW_v1_0(time_usec,sensor_id,flow_x,flow_y,flow_comp_m_x,flow_comp_m_y,quality,ground_distance)
	S.time_usec = typecast(uint64(time_usec),'uint64');		% Timestamp (UNIX)
	S.sensor_id = typecast(uint8(sensor_id),'uint8');		% Sensor ID
	S.flow_x = typecast(int16(flow_x),'int16');		% Flow in pixels * 10 in x-sensor direction (dezi-pixels)
	S.flow_y = typecast(int16(flow_y),'int16');		% Flow in pixels * 10 in y-sensor direction (dezi-pixels)
	S.flow_comp_m_x = typecast(single(flow_comp_m_x),'single');		% Flow in meters in x-sensor direction, angular-speed compensated
	S.flow_comp_m_y = typecast(single(flow_comp_m_y),'single');		% Flow in meters in y-sensor direction, angular-speed compensated
	S.quality = typecast(uint8(quality),'uint8');		% Optical flow quality / confidence. 0: bad, 255: maximum quality
	S.ground_distance = typecast(single(ground_distance),'single');		% Ground distance in meters. Positive value: distance known. Negative value: Unknown distance
	p = encode_OPTICAL_FLOW_v1_0(S);
return
