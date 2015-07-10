%%  case: 181
function S = parse_WATCHDOG_PROCESS_INFO_v1_0(p)
	name = [ ...
		{'watchdog_id'}	 ... %% Watchdog ID
		{'process_id'}	 ... %% Process ID
		{'name'}		 ... %% Process name
		{'arguments'}	 ... %% Process arguments
		{'timeout'}		 ... %% Timeout (seconds)
		];
	byte = [ 2 2 100 147 4 ];
	type = [ {'uint16'} {'uint16'} {'uint8'} {'uint8'} {'int32'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

