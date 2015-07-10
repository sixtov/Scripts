%%  case: 117
%%~ Request a list of available logs. On some systems calling this may stop on-board 
%%~ logging until LOG_REQUEST_END is called.
function p = encode_LOG_REQUEST_LIST_v1_0(S)
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
	messid = uint8(117);
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'start'}			 ... %% First log id (0 for first available)
		{'end'}				 ... %% Last log id (0xffff for last available)
		];
	byte = [ 1 1 2 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint16'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode start data field
	val = typecast(S.start,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode end data field
	val = typecast(S.end,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
