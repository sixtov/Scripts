%%%%  case: 181
function p = encodeValues_WATCHDOG_PROCESS_INFO_v1_0(watchdog_id,process_id,name,arguments,timeout)
	S.watchdog_id = typecast(uint16(watchdog_id),'uint16');		% Watchdog ID
	S.process_id = typecast(uint16(process_id),'uint16');		% Process ID
	S.name = typecast(uint8(name),'uint8');		% Process name
	S.arguments = typecast(uint8(arguments),'uint8');		% Process arguments
	S.timeout = typecast(int32(timeout),'int32');		% Timeout (seconds)
	p = encode_WATCHDOG_PROCESS_INFO_v1_0(S);
return
