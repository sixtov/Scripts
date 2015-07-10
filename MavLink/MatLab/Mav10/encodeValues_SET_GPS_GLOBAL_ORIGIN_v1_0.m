%%%%  case: 48
%%~ As local waypoints exist, the global MISSION reference allows to transform between 
%%~ the local coordinate frame and the global (GPS) coordinate frame. This can be 
%%~ necessary when e.g. in- and outdoor settings are connected and the MAV should move 
%%~ from in- to outdoor.
function p = encodeValues_SET_GPS_GLOBAL_ORIGIN_v1_0(target_system,latitude,longitude,altitude)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.latitude = typecast(int32(latitude),'int32');		% Latitude (WGS84), in degrees * 1E7
	S.longitude = typecast(int32(longitude),'int32');		% Longitude (WGS84, in degrees * 1E7
	S.altitude = typecast(int32(altitude),'int32');		% Altitude (WGS84), in meters * 1000 (positive for up)
	p = encode_SET_GPS_GLOBAL_ORIGIN_v1_0(S);
return
