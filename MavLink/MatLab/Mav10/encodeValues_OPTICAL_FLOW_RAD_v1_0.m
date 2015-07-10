%%%%  case: 106
%%~ Optical flow from an angular rate flow sensor (e.g. PX4FLOW or mouse sensor)
function p = encodeValues_OPTICAL_FLOW_RAD_v1_0(time_usec,sensor_id,integration_time_us,integrated_x,integrated_y,integrated_xgyro,integrated_ygyro,integrated_zgyro,temperature,quality,time_delta_distance_us,distance)
	S.time_usec = typecast(uint64(time_usec),'uint64');		% Timestamp (microseconds, synced to UNIX time or since system boot)
	S.sensor_id = typecast(uint8(sensor_id),'uint8');		% Sensor ID
	S.integration_time_us = typecast(uint32(integration_time_us),'uint32');		% Integration time in microseconds. Divide integrated_x and integrated_y by the integration time to obtain average flow. The integration time also indicates the.
	S.integrated_x = typecast(single(integrated_x),'single');		% Flow in radians around X axis (Sensor RH rotation about the X axis induces a positive flow. Sensor linear motion along the positive Y axis induces a negative flow.)
	S.integrated_y = typecast(single(integrated_y),'single');		% Flow in radians around Y axis (Sensor RH rotation about the Y axis induces a positive flow. Sensor linear motion along the positive X axis induces a positive flow.)
	S.integrated_xgyro = typecast(single(integrated_xgyro),'single');		% RH rotation around X axis (rad)
	S.integrated_ygyro = typecast(single(integrated_ygyro),'single');		% RH rotation around Y axis (rad)
	S.integrated_zgyro = typecast(single(integrated_zgyro),'single');		% RH rotation around Z axis (rad)
	S.temperature = typecast(int16(temperature),'int16');		% Temperature * 100 in centi-degrees Celsius
	S.quality = typecast(uint8(quality),'uint8');		% Optical flow quality / confidence. 0: no valid flow, 255: maximum quality
	S.time_delta_distance_us = typecast(uint32(time_delta_distance_us),'uint32');		% Time in microseconds since the distance was sampled.
	S.distance = typecast(single(distance),'single');		% Distance to the center of the flow field in meters. Positive value (including zero): distance known. Negative value: Unknown distance.
	p = encode_OPTICAL_FLOW_RAD_v1_0(S);
return
