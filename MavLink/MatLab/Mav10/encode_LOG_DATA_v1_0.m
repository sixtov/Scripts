%%  case: 120
%%~ Reply to LOG_REQUEST_DATA
function p = encode_LOG_DATA_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(97);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(120);
	name = [ ...
		{'id'}		 ... %% Log id (from LOG_ENTRY reply)
		{'ofs'}		 ... %% Offset into the log
		{'count'}	 ... %% Number of bytes (zero for end of log)
		{'data'}	 ... %% log data
		];
	byte = [ 2 4 1 90 ];
	type = [ {'uint16'} {'uint32'} {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode id data field
	val = typecast(S.id,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ofs data field
	val = typecast(S.ofs,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode count data field
	val = typecast(S.count,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode data data field
	val = typecast(S.data,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
