%%%%  case: 32
%%~ The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
%%~ frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down 
%%~ convention)
function p = encodeValues_LOCAL_POSITION_NED_v1_0(time_boot_ms,x,y,z,vx,vy,vz)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp (milliseconds since system boot)
	S.x = typecast(single(x),'single');		% X Position
	S.y = typecast(single(y),'single');		% Y Position
	S.z = typecast(single(z),'single');		% Z Position
	S.vx = typecast(single(vx),'single');		% X Speed
	S.vy = typecast(single(vy),'single');		% Y Speed
	S.vz = typecast(single(vz),'single');		% Z Speed
	p = encode_LOCAL_POSITION_NED_v1_0(S);
return
