%%%%  case: 250
function p = encodeValues_DEBUG_VECT_v1_0(name,time_usec,x,y,z)
	S.name = typecast(uint8(name),'uint8');		% Name
	S.time_usec = typecast(uint64(time_usec),'uint64');		% Timestamp
	S.x = typecast(single(x),'single');		% x
	S.y = typecast(single(y),'single');		% y
	S.z = typecast(single(z),'single');		% z
	p = encode_DEBUG_VECT_v1_0(S);
return
