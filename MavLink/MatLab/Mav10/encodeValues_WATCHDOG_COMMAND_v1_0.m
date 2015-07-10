%%%%  case: 183
function p = encodeValues_WATCHDOG_COMMAND_v1_0(target_system_id,watchdog_id,process_id,command_id)
	S.target_system_id = typecast(uint8(target_system_id),'uint8');		% Target system ID
	S.watchdog_id = typecast(uint16(watchdog_id),'uint16');		% Watchdog ID
	S.process_id = typecast(uint16(process_id),'uint16');		% Process ID
	S.command_id = typecast(uint8(command_id),'uint8');		% Command ID
	p = encode_WATCHDOG_COMMAND_v1_0(S);
return
