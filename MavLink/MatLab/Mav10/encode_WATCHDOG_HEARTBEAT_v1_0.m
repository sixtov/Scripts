%%  case: 180
function p = encode_WATCHDOG_HEARTBEAT_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(4);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(180);
	name = [ ...
		{'watchdog_id'}		 ... %% Watchdog ID
		{'process_count'}	 ... %% Number of processes
		];
	byte = [ 2 2 ];
	type = [ {'uint16'} {'uint16'} ];

	p = [head len pnum sysid id messid];
	%% Encode watchdog_id data field
	val = typecast(S.watchdog_id,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode process_count data field
	val = typecast(S.process_count,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
