%%  case: 2
%%~ The system time is the time of the master clock, typically the computer clock of 
%%~ the main onboard computer.
function S = parse_SYSTEM_TIME(S,p)
	name = [ ...
		{'time_unix_usec'}	 ... %% Timestamp of the master clock in microseconds since UNIX epoch.
		{'time_boot_ms'}	 ... %% Timestamp of the component clock since boot time in milliseconds.
		];
	byte = [ 8 4 ];
	type = [ {'uint64'} {'uint32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

