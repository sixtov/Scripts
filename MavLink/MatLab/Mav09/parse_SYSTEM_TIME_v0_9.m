%%  case: 2
%%~ The system time is the time of the master clock, typically the computer clock of 
%%~ the main onboard computer.
function S = parse_SYSTEM_TIME_v0_9(p)
	name = [ ...
		{'time_usec'}	 ... %% Timestamp of the master clock in microseconds since UNIX epoch.
		];
	byte = [ 8 ];
	type = [ {'uint64'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

