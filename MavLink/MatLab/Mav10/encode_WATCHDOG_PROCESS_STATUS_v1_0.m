%%  case: 182
function p = encode_WATCHDOG_PROCESS_STATUS_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(12);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(182);
	name = [ ...
		{'watchdog_id'}	 ... %% Watchdog ID
		{'process_id'}	 ... %% Process ID
		{'state'}		 ... %% Is running / finished / suspended / crashed
		{'muted'}		 ... %% Is muted
		{'pid'}			 ... %% PID
		{'crashes'}		 ... %% Number of crashes
		];
	byte = [ 2 2 1 1 4 2 ];
	type = [ {'uint16'} {'uint16'} {'uint8'} {'uint8'} {'int32'} {'uint16'} ];

	p = [head len pnum sysid id messid];
	%% Encode watchdog_id data field
	val = typecast(S.watchdog_id,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode process_id data field
	val = typecast(S.process_id,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode state data field
	val = typecast(S.state,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode muted data field
	val = typecast(S.muted,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pid data field
	val = typecast(S.pid,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode crashes data field
	val = typecast(S.crashes,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
