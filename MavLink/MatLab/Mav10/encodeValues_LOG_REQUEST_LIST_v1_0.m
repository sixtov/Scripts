%%%%  case: 117
%%~ Request a list of available logs. On some systems calling this may stop on-board 
%%~ logging until LOG_REQUEST_END is called.
function p = encodeValues_LOG_REQUEST_LIST_v1_0(target_system,target_component,start,end)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.start = typecast(uint16(start),'uint16');		% First log id (0 for first available)
	S.end = typecast(uint16(end),'uint16');		% Last log id (0xffff for last available)
	p = encode_LOG_REQUEST_LIST_v1_0(S);
return
