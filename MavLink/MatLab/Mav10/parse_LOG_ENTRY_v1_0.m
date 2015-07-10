%%  case: 118
%%~ Reply to LOG_REQUEST_LIST
function S = parse_LOG_ENTRY_v1_0(p)
	name = [ ...
		{'id'}			 ... %% Log id
		{'num_logs'}	 ... %% Total number of logs
		{'last_log_num'} ... %% High log number
		{'time_utc'}	 ... %% UTC timestamp of log in seconds since 1970, or 0 if not available
		{'size'}		 ... %% Size of the log (may be approximate) in bytes
		];
	byte = [ 2 2 2 4 4 ];
	type = [ {'uint16'} {'uint16'} {'uint16'} {'uint32'} {'uint32'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

