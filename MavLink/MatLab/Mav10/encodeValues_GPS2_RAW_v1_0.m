%%%%  case: 124
%%~ Second GPS data. Coordinate frame is right-handed, Z-axis up (GPS frame).
function p = encodeValues_GPS2_RAW_v1_0(time_usec,fix_type,lat,lon,alt,eph,epv,vel,cog,satellites_visible,dgps_numch,dgps_age)
	S.time_usec = typecast(uint64(time_usec),'uint64');		% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
	S.fix_type = typecast(uint8(fix_type),'uint8');		% 0-1: no fix, 2: 2D fix, 3: 3D fix, 4: DGPS fix, 5: RTK Fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
	S.lat = typecast(int32(lat),'int32');		% Latitude (WGS84), in degrees * 1E7
	S.lon = typecast(int32(lon),'int32');		% Longitude (WGS84), in degrees * 1E7
	S.alt = typecast(int32(alt),'int32');		% Altitude (AMSL, not WGS84), in meters * 1000 (positive for up)
	S.eph = typecast(uint16(eph),'uint16');		% GPS HDOP horizontal dilution of position in cm (m*100). If unknown, set to: UINT16_MAX
	S.epv = typecast(uint16(epv),'uint16');		% GPS VDOP vertical dilution of position in cm (m*100). If unknown, set to: UINT16_MAX
	S.vel = typecast(uint16(vel),'uint16');		% GPS ground speed (m/s * 100). If unknown, set to: UINT16_MAX
	S.cog = typecast(uint16(cog),'uint16');		% Course over ground (NOT heading, but direction of movement) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX
	S.satellites_visible = typecast(uint8(satellites_visible),'uint8');		% Number of satellites visible. If unknown, set to 255
	S.dgps_numch = typecast(uint8(dgps_numch),'uint8');		% Number of DGPS satellites
	S.dgps_age = typecast(uint32(dgps_age),'uint32');		% Age of DGPS info
	p = encode_GPS2_RAW_v1_0(S);
return
