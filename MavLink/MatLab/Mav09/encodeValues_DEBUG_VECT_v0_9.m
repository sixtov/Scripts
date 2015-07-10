%%%%  case: 251
function p = encodeValues_DEBUG_VECT_v0_9(name,usec,x,y,z)
	S.name = typecast(uint8(name),'uint8');		% Name
	S.usec = typecast(uint64(usec),'uint64');		% Timestamp
	S.x = typecast(single(x),'single');		% x
	S.y = typecast(single(y),'single');		% y
	S.z = typecast(single(z),'single');		% z
	p = encode_DEBUG_VECT_v0_9(S);
return
