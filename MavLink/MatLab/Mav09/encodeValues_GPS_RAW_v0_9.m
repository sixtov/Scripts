%%%%  case: 32
%%~ The global position, as returned by the Global Positioning System (GPS). This is 
%%~ NOT the global position estimate of the sytem, but rather a RAW sensor value. See 
%%~ message GLOBAL_POSITION for the global position estimate. Coordinate frame is 
%%~ right-handed, Z-axis up (GPS frame)
function p = encodeValues_GPS_RAW_v0_9(usec,fix_type,lat,lon,alt,eph,epv,v,hdg)
	S.usec = typecast(uint64(usec),'uint64');		% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
	S.fix_type = typecast(uint8(fix_type),'uint8');		% 0-1: no fix, 2: 2D fix, 3: 3D fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
	S.lat = typecast(single(lat),'single');		% Latitude in degrees
	S.lon = typecast(single(lon),'single');		% Longitude in degrees
	S.alt = typecast(single(alt),'single');		% Altitude in meters
	S.eph = typecast(single(eph),'single');		% GPS HDOP
	S.epv = typecast(single(epv),'single');		% GPS VDOP
	S.v = typecast(single(v),'single');		% GPS ground speed
	S.hdg = typecast(single(hdg),'single');		% Compass heading in degrees, 0..360 degrees
	p = encode_GPS_RAW_v0_9(S);
return
