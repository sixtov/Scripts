%%  case: 2
%%~ The system time is the time of the master clock, typically the computer clock of 
%%~ the main onboard computer.
function S = parse_SYSTEM_TIME_v0_9(S,p)
	name = [ ...
		{'time_usec'}	 ... %% Timestamp of the master clock in microseconds since UNIX epoch.
		];
	byte = [ 8 ];
	type = [ {'uint64'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

