%%%%  case: 254
%%~ Send a debug value. The index is used to discriminate between values. These values 
%%~ show up in the plot of QGroundControl as DEBUG N.
function p = encodeValues_DEBUG_v1_0(time_boot_ms,ind,value)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp (milliseconds since system boot)
	S.ind = typecast(uint8(ind),'uint8');		% index of debug variable
	S.value = typecast(single(value),'single');		% DEBUG value
	p = encode_DEBUG_v1_0(S);
return
