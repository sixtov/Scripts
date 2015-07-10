%%%%  case: 114
%%~ Message that provides 6 dof position data about other traffic. This includes: Vehicle 
%%~ number, latitud (deg), longitud (deg), altitud(meters), roll (deg), pitch 
%%~ (deg), heading(deg)
function p = encodeValues_TRAFFIC_DATA_v0_9(ID,lat,lon,alt,roll,pitch,heading,ownship_flag)
	S.ID = typecast(uint8(ID),'uint8');		% vehicle ID
	S.lat = typecast(single(lat),'single');		% latitude (deg)
	S.lon = typecast(single(lon),'single');		% longitude (deg)
	S.alt = typecast(single(alt),'single');		% altitude (meters)
	S.roll = typecast(single(roll),'single');		% roll (deg)
	S.pitch = typecast(single(pitch),'single');		% pitch (deg)
	S.heading = typecast(single(heading),'single');		% heading (deg)
	S.ownship_flag = typecast(uint8(ownship_flag),'uint8');		% identifies whether the aircraft is ownship (1) or not (0)
	p = encode_TRAFFIC_DATA_v0_9(S);
return
