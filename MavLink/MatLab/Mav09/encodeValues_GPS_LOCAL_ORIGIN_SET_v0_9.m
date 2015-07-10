%%%%  case: 49
%%~ Once the MAV sets a new GPS-Local correspondence, this message announces the origin 
%%~ (0,0,0) position
function p = encodeValues_GPS_LOCAL_ORIGIN_SET_v0_9(latitude,longitude,altitude)
	S.latitude = typecast(int32(latitude),'int32');		% Latitude (WGS84), expressed as * 1E7
	S.longitude = typecast(int32(longitude),'int32');		% Longitude (WGS84), expressed as * 1E7
	S.altitude = typecast(int32(altitude),'int32');		% Altitude(WGS84), expressed as * 1000
	p = encode_GPS_LOCAL_ORIGIN_SET_v0_9(S);
return
