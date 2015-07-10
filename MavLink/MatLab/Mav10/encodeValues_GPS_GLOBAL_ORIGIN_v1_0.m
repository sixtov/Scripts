%%%%  case: 49
%%~ Once the MAV sets a new GPS-Local correspondence, this message announces the origin 
%%~ (0,0,0) position
function p = encodeValues_GPS_GLOBAL_ORIGIN_v1_0(latitude,longitude,altitude)
	S.latitude = typecast(int32(latitude),'int32');		% Latitude (WGS84), in degrees * 1E7
	S.longitude = typecast(int32(longitude),'int32');		% Longitude (WGS84), in degrees * 1E7
	S.altitude = typecast(int32(altitude),'int32');		% Altitude (AMSL), in meters * 1000 (positive for up)
	p = encode_GPS_GLOBAL_ORIGIN_v1_0(S);
return
