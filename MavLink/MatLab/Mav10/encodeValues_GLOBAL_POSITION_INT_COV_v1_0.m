%%%%  case: 63
%%~ The filtered global position (e.g. fused GPS and accelerometers). The position is 
%%~ in GPS-frame (right-handed, Z-up). It  is designed as scaled integer message since 
%%~ the resolution of float is not sufficient. NOTE: This message is intended for 
%%~ onboard networks / companion computers and higher-bandwidth links and optimized 
%%~ for accuracy and completeness. Please use the GLOBAL_POSITION_INT message for 
%%~ a minimal subset.
function p = encodeValues_GLOBAL_POSITION_INT_COV_v1_0(time_boot_ms,time_utc,estimator_type,lat,lon,alt,relative_alt,vx,vy,vz,covariance)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp (milliseconds since system boot)
	S.time_utc = typecast(uint64(time_utc),'uint64');		% Timestamp (microseconds since UNIX epoch) in UTC. 0 for unknown. Commonly filled by the precision time source of a GPS receiver.
	S.estimator_type = typecast(uint8(estimator_type),'uint8');		% Class id of the estimator this estimate originated from.
	S.lat = typecast(int32(lat),'int32');		% Latitude, expressed as degrees * 1E7
	S.lon = typecast(int32(lon),'int32');		% Longitude, expressed as degrees * 1E7
	S.alt = typecast(int32(alt),'int32');		% Altitude in meters, expressed as * 1000 (millimeters), above MSL
	S.relative_alt = typecast(int32(relative_alt),'int32');		% Altitude above ground in meters, expressed as * 1000 (millimeters)
	S.vx = typecast(single(vx),'single');		% Ground X Speed (Latitude), expressed as m/s
	S.vy = typecast(single(vy),'single');		% Ground Y Speed (Longitude), expressed as m/s
	S.vz = typecast(single(vz),'single');		% Ground Z Speed (Altitude), expressed as m/s
	S.covariance = typecast(single(covariance),'single');		% Covariance matrix (first six entries are the first ROW, next six entries are the second row, etc.)
	p = encode_GLOBAL_POSITION_INT_COV_v1_0(S);
return
