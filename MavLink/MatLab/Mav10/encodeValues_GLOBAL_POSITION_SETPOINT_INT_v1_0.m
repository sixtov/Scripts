%%%%  case: 52
%%~ Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
%%~ and to the GCS.
function p = encodeValues_GLOBAL_POSITION_SETPOINT_INT_v1_0(coordinate_frame,latitude,longitude,altitude,yaw)
	S.coordinate_frame = typecast(uint8(coordinate_frame),'uint8');		% Coordinate frame - valid values are only MAV_FRAME_GLOBAL or MAV_FRAME_GLOBAL_RELATIVE_ALT
	S.latitude = typecast(int32(latitude),'int32');		% Latitude (WGS84), in degrees * 1E7
	S.longitude = typecast(int32(longitude),'int32');		% Longitude (WGS84), in degrees * 1E7
	S.altitude = typecast(int32(altitude),'int32');		% Altitude (WGS84), in meters * 1000 (positive for up)
	S.yaw = typecast(int16(yaw),'int16');		% Desired yaw angle in degrees * 100
	p = encode_GLOBAL_POSITION_SETPOINT_INT_v1_0(S);
return
