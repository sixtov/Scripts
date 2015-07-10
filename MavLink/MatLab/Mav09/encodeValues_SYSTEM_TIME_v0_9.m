%%%%  case: 2
%%~ The system time is the time of the master clock, typically the computer clock of 
%%~ the main onboard computer.
function p = encodeValues_SYSTEM_TIME_v0_9(time_usec)
	S.time_usec = typecast(uint64(time_usec),'uint64');		% Timestamp of the master clock in microseconds since UNIX epoch.
	p = encode_SYSTEM_TIME_v0_9(S);
return
