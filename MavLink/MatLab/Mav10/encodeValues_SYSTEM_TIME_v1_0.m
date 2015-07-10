%%%%  case: 2
%%~ The system time is the time of the master clock, typically the computer clock of 
%%~ the main onboard computer.
function p = encodeValues_SYSTEM_TIME_v1_0(time_unix_usec,time_boot_ms)
	S.time_unix_usec = typecast(uint64(time_unix_usec),'uint64');		% Timestamp of the master clock in microseconds since UNIX epoch.
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp of the component clock since boot time in milliseconds.
	p = encode_SYSTEM_TIME_v1_0(S);
return
