%%%%  case: 138
%%~ Motion capture attitude and position
function p = encodeValues_ATT_POS_MOCAP_v1_0(time_usec,q,x,y,z)
	S.time_usec = typecast(uint64(time_usec),'uint64');		% Timestamp (micros since boot or Unix epoch)
	S.q = typecast(single(q),'single');		% Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0)
	S.x = typecast(single(x),'single');		% X position in meters (NED)
	S.y = typecast(single(y),'single');		% Y position in meters (NED)
	S.z = typecast(single(z),'single');		% Z position in meters (NED)
	p = encode_ATT_POS_MOCAP_v1_0(S);
return
