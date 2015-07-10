%%  case: 119
%%~ Request a chunk of a log
function S = parse_LOG_REQUEST_DATA(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'id'}				 ... %% Log id (from LOG_ENTRY reply)
		{'ofs'}				 ... %% Offset into the log
		{'count'}			 ... %% Number of bytes
		];
	byte = [ 1 1 2 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint32'} {'uint32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

