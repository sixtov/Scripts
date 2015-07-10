%%%%  case: 31
%%~ The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
%%~ frame is right-handed, Z-axis down (aeronautical frame)
function p = encodeValues_LOCAL_POSITION_v0_9(usec,x,y,z,vx,vy,vz)
	S.usec = typecast(uint64(usec),'uint64');		% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
	S.x = typecast(single(x),'single');		% X Position
	S.y = typecast(single(y),'single');		% Y Position
	S.z = typecast(single(z),'single');		% Z Position
	S.vx = typecast(single(vx),'single');		% X Speed
	S.vy = typecast(single(vy),'single');		% Y Speed
	S.vz = typecast(single(vz),'single');		% Z Speed
	p = encode_LOCAL_POSITION_v0_9(S);
return
