%%%%  case: 119
%%~ Request a chunk of a log
function p = encodeValues_LOG_REQUEST_DATA_v1_0(target_system,target_component,id,ofs,count)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.id = typecast(uint16(id),'uint16');		% Log id (from LOG_ENTRY reply)
	S.ofs = typecast(uint32(ofs),'uint32');		% Offset into the log
	S.count = typecast(uint32(count),'uint32');		% Number of bytes
	p = encode_LOG_REQUEST_DATA_v1_0(S);
return
