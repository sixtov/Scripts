%%%%  case: 132
function p = encodeValues_DISTANCE_SENSOR_v1_0(time_boot_ms,min_distance,max_distance,current_distance,type,id,orientation,covariance)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Time since system boot
	S.min_distance = typecast(uint16(min_distance),'uint16');		% Minimum distance the sensor can measure in centimeters
	S.max_distance = typecast(uint16(max_distance),'uint16');		% Maximum distance the sensor can measure in centimeters
	S.current_distance = typecast(uint16(current_distance),'uint16');		% Current distance reading
	S.type = typecast(uint8(type),'uint8');		% Type from MAV_DISTANCE_SENSOR enum.
	S.id = typecast(uint8(id),'uint8');		% Onboard ID of the sensor
	S.orientation = typecast(uint8(orientation),'uint8');		% Direction the sensor faces from FIXME enum.
	S.covariance = typecast(uint8(covariance),'uint8');		% Measurement covariance in centimeters, 0 for unknown / invalid readings
	p = encode_DISTANCE_SENSOR_v1_0(S);
return
