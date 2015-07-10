%%  case: 111
%%~ Time synchronization message.
function p = encode_TIMESYNC_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(16);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(111);
	name = [ ...
		{'tc1'}	 ... %% Time sync timestamp 1
		{'ts1'}	 ... %% Time sync timestamp 2
		];
	byte = [ 8 8 ];
	type = [ {'int64'} {'int64'} ];

	p = [head len pnum sysid id messid];
	%% Encode tc1 data field
	val = typecast(S.tc1,'int64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ts1 data field
	val = typecast(S.ts1,'int64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
