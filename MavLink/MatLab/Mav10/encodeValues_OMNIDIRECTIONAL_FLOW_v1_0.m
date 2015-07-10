%%%%  case: 106
%%~ Optical flow from an omnidirectional flow sensor (e.g. PX4FLOW with wide angle lens)
function p = encodeValues_OMNIDIRECTIONAL_FLOW_v1_0(time_usec,sensor_id,left,right,quality,front_distance_m)
	S.time_usec = typecast(uint64(time_usec),'uint64');		% Timestamp (microseconds, synced to UNIX time or since system boot)
	S.sensor_id = typecast(uint8(sensor_id),'uint8');		% Sensor ID
	S.left = typecast(int16(left),'int16');		% Flow in deci pixels (1 = 0.1 pixel) on left hemisphere
	S.right = typecast(int16(right),'int16');		% Flow in deci pixels (1 = 0.1 pixel) on right hemisphere
	S.quality = typecast(uint8(quality),'uint8');		% Optical flow quality / confidence. 0: bad, 255: maximum quality
	S.front_distance_m = typecast(single(front_distance_m),'single');		% Front distance in meters. Positive value (including zero): distance known. Negative value: Unknown distance
	p = encode_OMNIDIRECTIONAL_FLOW_v1_0(S);
return
