%%  case: 2
%%~ The system time is the time of the master clock, typically the computer clock of 
%%~ the main onboard computer.
function p = encode_SYSTEM_TIME_v0_9(S)
	name = [ ...
		{'time_usec'}	 ... %% Timestamp of the master clock in microseconds since UNIX epoch.
		];
	byte = [ 8 ];
	type = [ {'uint64'} ];

	p = [];
	%% Encode time_usec data field
	val = typecast(S.time_usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
