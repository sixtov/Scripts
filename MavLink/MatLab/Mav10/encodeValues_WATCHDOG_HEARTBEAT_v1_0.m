%%%%  case: 180
function p = encodeValues_WATCHDOG_HEARTBEAT_v1_0(watchdog_id,process_count)
	S.watchdog_id = typecast(uint16(watchdog_id),'uint16');		% Watchdog ID
	S.process_count = typecast(uint16(process_count),'uint16');		% Number of processes
	p = encode_WATCHDOG_HEARTBEAT_v1_0(S);
return
