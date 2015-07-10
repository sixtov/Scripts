%%%%  case: 33
%%~ The filtered global position (e.g. fused GPS and accelerometers). The position is 
%%~ in GPS-frame (right-handed, Z-up). It                is designed as scaled integer 
%%~ message since the resolution of float is not sufficient.
function p = encodeValues_GLOBAL_POSITION_INT_v1_0(time_boot_ms,lat,lon,alt,relative_alt,vx,vy,vz,hdg)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp (milliseconds since system boot)
	S.lat = typecast(int32(lat),'int32');		% Latitude, expressed as * 1E7
	S.lon = typecast(int32(lon),'int32');		% Longitude, expressed as * 1E7
	S.alt = typecast(int32(alt),'int32');		% Altitude in meters, expressed as * 1000 (millimeters), AMSL (not WGS84 - note that virtually all GPS modules provide the AMSL as well)
	S.relative_alt = typecast(int32(relative_alt),'int32');		% Altitude above ground in meters, expressed as * 1000 (millimeters)
	S.vx = typecast(int16(vx),'int16');		% Ground X Speed (Latitude), expressed as m/s * 100
	S.vy = typecast(int16(vy),'int16');		% Ground Y Speed (Longitude), expressed as m/s * 100
	S.vz = typecast(int16(vz),'int16');		% Ground Z Speed (Altitude), expressed as m/s * 100
	S.hdg = typecast(uint16(hdg),'uint16');		% Compass heading in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX
	p = encode_GLOBAL_POSITION_INT_v1_0(S);
return
