%%%%  case: 120
%%~ Reply to LOG_REQUEST_DATA
function p = encodeValues_LOG_DATA_v1_0(id,ofs,count,data)
	S.id = typecast(uint16(id),'uint16');		% Log id (from LOG_ENTRY reply)
	S.ofs = typecast(uint32(ofs),'uint32');		% Offset into the log
	S.count = typecast(uint8(count),'uint8');		% Number of bytes (zero for end of log)
	S.data = typecast(uint8(data),'uint8');		% log data
	p = encode_LOG_DATA_v1_0(S);
return
