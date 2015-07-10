%%%%  case: 118
%%~ Reply to LOG_REQUEST_LIST
function p = encodeValues_LOG_ENTRY_v1_0(id,num_logs,last_log_num,time_utc,size)
	S.id = typecast(uint16(id),'uint16');		% Log id
	S.num_logs = typecast(uint16(num_logs),'uint16');		% Total number of logs
	S.last_log_num = typecast(uint16(last_log_num),'uint16');		% High log number
	S.time_utc = typecast(uint32(time_utc),'uint32');		% UTC timestamp of log in seconds since 1970, or 0 if not available
	S.size = typecast(uint32(size),'uint32');		% Size of the log (may be approximate) in bytes
	p = encode_LOG_ENTRY_v1_0(S);
return
