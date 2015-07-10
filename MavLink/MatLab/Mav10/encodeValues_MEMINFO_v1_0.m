%%%%  case: 152
%%~ state of APM memory
function p = encodeValues_MEMINFO_v1_0(brkval,freemem)
	S.brkval = typecast(uint16(brkval),'uint16');		% heap top
	S.freemem = typecast(uint16(freemem),'uint16');		% free memory
	p = encode_MEMINFO_v1_0(S);
return
