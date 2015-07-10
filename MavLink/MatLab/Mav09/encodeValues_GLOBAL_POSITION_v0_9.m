%%%%  case: 33
%%~ The filtered global position (e.g. fused GPS and accelerometers). Coordinate frame 
%%~ is right-handed, Z-axis up (GPS frame)
function p = encodeValues_GLOBAL_POSITION_v0_9(usec,lat,lon,alt,vx,vy,vz)
	S.usec = typecast(uint64(usec),'uint64');		% Timestamp (microseconds since unix epoch)
	S.lat = typecast(single(lat),'single');		% Latitude, in degrees
	S.lon = typecast(single(lon),'single');		% Longitude, in degrees
	S.alt = typecast(single(alt),'single');		% Absolute altitude, in meters
	S.vx = typecast(single(vx),'single');		% X Speed (in Latitude direction, positive: going north)
	S.vy = typecast(single(vy),'single');		% Y Speed (in Longitude direction, positive: going east)
	S.vz = typecast(single(vz),'single');		% Z Speed (in Altitude direction, positive: going up)
	p = encode_GLOBAL_POSITION_v0_9(S);
return
