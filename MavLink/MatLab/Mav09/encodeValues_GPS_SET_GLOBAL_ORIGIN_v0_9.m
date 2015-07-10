%%%%  case: 48
%%~ As local waypoints exist, the global waypoint reference allows to transform between 
%%~ the local coordinate frame and the global (GPS) coordinate frame. This can be 
%%~ necessary when e.g. in- and outdoor settings are connected and the MAV should 
%%~ move from in- to outdoor.
function p = encodeValues_GPS_SET_GLOBAL_ORIGIN_v0_9(target_system,target_component,latitude,longitude,altitude)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.latitude = typecast(int32(latitude),'int32');		% global position * 1E7
	S.longitude = typecast(int32(longitude),'int32');		% global position * 1E7
	S.altitude = typecast(int32(altitude),'int32');		% global position * 1000
	p = encode_GPS_SET_GLOBAL_ORIGIN_v0_9(S);
return
