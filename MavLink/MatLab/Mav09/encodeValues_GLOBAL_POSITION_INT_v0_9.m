%%%%  case: 73
%%~ The filtered global position (e.g. fused GPS and accelerometers). The position is 
%%~ in GPS-frame (right-handed, Z-up)
function p = encodeValues_GLOBAL_POSITION_INT_v0_9(lat,lon,alt,vx,vy,vz)
	S.lat = typecast(int32(lat),'int32');		% Latitude, expressed as * 1E7
	S.lon = typecast(int32(lon),'int32');		% Longitude, expressed as * 1E7
	S.alt = typecast(int32(alt),'int32');		% Altitude in meters, expressed as * 1000 (millimeters)
	S.vx = typecast(int16(vx),'int16');		% Ground X Speed (Latitude), expressed as m/s * 100
	S.vy = typecast(int16(vy),'int16');		% Ground Y Speed (Longitude), expressed as m/s * 100
	S.vz = typecast(int16(vz),'int16');		% Ground Z Speed (Altitude), expressed as m/s * 100
	p = encode_GLOBAL_POSITION_INT_v0_9(S);
return
