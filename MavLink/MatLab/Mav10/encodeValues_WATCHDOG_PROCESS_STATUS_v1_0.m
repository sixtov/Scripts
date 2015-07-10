%%%%  case: 182
function p = encodeValues_WATCHDOG_PROCESS_STATUS_v1_0(watchdog_id,process_id,state,muted,pid,crashes)
	S.watchdog_id = typecast(uint16(watchdog_id),'uint16');		% Watchdog ID
	S.process_id = typecast(uint16(process_id),'uint16');		% Process ID
	S.state = typecast(uint8(state),'uint8');		% Is running / finished / suspended / crashed
	S.muted = typecast(uint8(muted),'uint8');		% Is muted
	S.pid = typecast(int32(pid),'int32');		% PID
	S.crashes = typecast(uint16(crashes),'uint16');		% Number of crashes
	p = encode_WATCHDOG_PROCESS_STATUS_v1_0(S);
return
