%%%%  case: 255
%%~ Send a debug value. The index is used to discriminate between values. These values 
%%~ show up in the plot of QGroundControl as DEBUG N.
function p = encodeValues_DEBUG_v0_9(ind,value)
	S.ind = typecast(uint8(ind),'uint8');		% index of debug variable
	S.value = typecast(single(value),'single');		% DEBUG value
	p = encode_DEBUG_v0_9(S);
return
