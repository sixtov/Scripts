%%%%  case: 171
%%~ Data packet, size 64
function p = encodeValues_DATA64_v1_0(type,len,data)
	S.type = typecast(uint8(type),'uint8');		% data type
	S.len = typecast(uint8(len),'uint8');		% data length
	S.data = typecast(uint8(data),'uint8');		% raw data
	p = encode_DATA64_v1_0(S);
return
