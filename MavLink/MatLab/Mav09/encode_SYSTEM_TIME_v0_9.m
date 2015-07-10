%%  case: 2
%%~ The system time is the time of the master clock, typically the computer clock of 
%%~ the main onboard computer.
function p = encode_SYSTEM_TIME_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(8);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(2);
	name = [ ...
		{'time_usec'}	 ... %% Timestamp of the master clock in microseconds since UNIX epoch.
		];
	byte = [ 8 ];
	type = [ {'uint64'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_usec data field
	val = typecast(S.time_usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
