%%  case: 120
%%~ Reply to LOG_REQUEST_DATA
function S = parse_LOG_DATA_v1_0(p)
	name = [ ...
		{'id'}		 ... %% Log id (from LOG_ENTRY reply)
		{'ofs'}		 ... %% Offset into the log
		{'count'}	 ... %% Number of bytes (zero for end of log)
		{'data'}	 ... %% log data
		];
	byte = [ 2 4 1 90 ];
	type = [ {'uint16'} {'uint32'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

