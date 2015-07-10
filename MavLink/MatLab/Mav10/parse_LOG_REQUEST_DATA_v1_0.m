%%  case: 119
%%~ Request a chunk of a log
function S = parse_LOG_REQUEST_DATA_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'id'}				 ... %% Log id (from LOG_ENTRY reply)
		{'ofs'}				 ... %% Offset into the log
		{'count'}			 ... %% Number of bytes
		];
	byte = [ 1 1 2 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint32'} {'uint32'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

