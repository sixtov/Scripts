%%  case: 181
function p = encode_WATCHDOG_PROCESS_INFO_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(255);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(181);
	name = [ ...
		{'watchdog_id'}	 ... %% Watchdog ID
		{'process_id'}	 ... %% Process ID
		{'name'}		 ... %% Process name
		{'arguments'}	 ... %% Process arguments
		{'timeout'}		 ... %% Timeout (seconds)
		];
	byte = [ 2 2 100 147 4 ];
	type = [ {'uint16'} {'uint16'} {'uint8'} {'uint8'} {'int32'} ];

	p = [head len pnum sysid id messid];
	%% Encode watchdog_id data field
	val = typecast(S.watchdog_id,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode process_id data field
	val = typecast(S.process_id,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode name data field
	val = typecast(S.name,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode arguments data field
	val = typecast(S.arguments,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode timeout data field
	val = typecast(S.timeout,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
