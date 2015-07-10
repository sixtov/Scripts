%%%%  case: 64
%%~ The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
%%~ frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down 
%%~ convention)
function p = encodeValues_LOCAL_POSITION_NED_COV_v1_0(time_boot_ms,time_utc,estimator_type,x,y,z,vx,vy,vz,covariance)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp (milliseconds since system boot)
	S.time_utc = typecast(uint64(time_utc),'uint64');		% Timestamp (microseconds since UNIX epoch) in UTC. 0 for unknown. Commonly filled by the precision time source of a GPS receiver.
	S.estimator_type = typecast(uint8(estimator_type),'uint8');		% Class id of the estimator this estimate originated from.
	S.x = typecast(single(x),'single');		% X Position
	S.y = typecast(single(y),'single');		% Y Position
	S.z = typecast(single(z),'single');		% Z Position
	S.vx = typecast(single(vx),'single');		% X Speed
	S.vy = typecast(single(vy),'single');		% Y Speed
	S.vz = typecast(single(vz),'single');		% Z Speed
	S.covariance = typecast(single(covariance),'single');		% Covariance matrix (first six entries are the first ROW, next six entries are the second row, etc.)
	p = encode_LOCAL_POSITION_NED_COV_v1_0(S);
return
