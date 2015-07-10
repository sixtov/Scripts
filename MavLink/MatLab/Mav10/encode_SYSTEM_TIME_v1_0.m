%%  case: 2
%%~ The system time is the time of the master clock, typically the computer clock of 
%%~ the main onboard computer.
function p = encode_SYSTEM_TIME_v1_0(S)
	name = [ ...
		{'time_unix_usec'}	 ... %% Timestamp of the master clock in microseconds since UNIX epoch.
		{'time_boot_ms'}	 ... %% Timestamp of the component clock since boot time in milliseconds.
		];
	byte = [ 8 4 ];
	type = [ {'uint64'} {'uint32'} ];

	p = [];
	%% Encode time_unix_usec data field
	val = typecast(S.time_unix_usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
