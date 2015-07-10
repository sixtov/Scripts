%%  case: 183
function p = encode_WATCHDOG_COMMAND_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(6);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(183);
	name = [ ...
		{'target_system_id'} ... %% Target system ID
		{'watchdog_id'}		 ... %% Watchdog ID
		{'process_id'}		 ... %% Process ID
		{'command_id'}		 ... %% Command ID
		];
	byte = [ 1 2 2 1 ];
	type = [ {'uint8'} {'uint16'} {'uint16'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system_id data field
	val = typecast(S.target_system_id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode watchdog_id data field
	val = typecast(S.watchdog_id,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode process_id data field
	val = typecast(S.process_id,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode command_id data field
	val = typecast(S.command_id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
