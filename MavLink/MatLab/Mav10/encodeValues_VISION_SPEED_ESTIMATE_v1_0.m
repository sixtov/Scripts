%%%%  case: 103
function p = encodeValues_VISION_SPEED_ESTIMATE_v1_0(usec,x,y,z)
	S.usec = typecast(uint64(usec),'uint64');		% Timestamp (microseconds, synced to UNIX time or since system boot)
	S.x = typecast(single(x),'single');		% Global X speed
	S.y = typecast(single(y),'single');		% Global Y speed
	S.z = typecast(single(z),'single');		% Global Z speed
	p = encode_VISION_SPEED_ESTIMATE_v1_0(S);
return
