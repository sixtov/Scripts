%%  case: 118
%%~ Reply to LOG_REQUEST_LIST
function p = encode_LOG_ENTRY(S)
	name = [ ...
		{'id'}			 ... %% Log id
		{'num_logs'}	 ... %% Total number of logs
		{'last_log_num'} ... %% High log number
		{'time_utc'}	 ... %% UTC timestamp of log in seconds since 1970, or 0 if not available
		{'size'}		 ... %% Size of the log (may be approximate) in bytes
		];
	byte = [ 2 2 2 4 4 ];
	type = [ {'uint16'} {'uint16'} {'uint16'} {'uint32'} {'uint32'} ];

	%% Encode id data field
	val = typecast(S.id,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode num_logs data field
	val = typecast(S.num_logs,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode last_log_num data field
	val = typecast(S.last_log_num,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode time_utc data field
	val = typecast(S.time_utc,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode size data field
	val = typecast(S.size,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
