%%%%  case: 131
function p = encodeValues_ENCAPSULATED_DATA_v1_0(seqnr,data)
	S.seqnr = typecast(uint16(seqnr),'uint16');		% sequence number (starting with 0 on every transmission)
	S.data = typecast(uint8(data),'uint8');		% image data bytes
	p = encode_ENCAPSULATED_DATA_v1_0(S);
return
