%%  case: 120
%%~ Reply to LOG_REQUEST_DATA
function S = parse_LOG_DATA(S,p)
	name = [ ...
		{'id'}		 ... %% Log id (from LOG_ENTRY reply)
		{'ofs'}		 ... %% Offset into the log
		{'count'}	 ... %% Number of bytes (zero for end of log)
		{'data'}	 ... %% log data
		];
	byte = [ 2 4 1 90 ];
	type = [ {'uint16'} {'uint32'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

