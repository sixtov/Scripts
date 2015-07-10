%%  case: 182
function S = parse_WATCHDOG_PROCESS_STATUS_v1_0(p)
	name = [ ...
		{'watchdog_id'}	 ... %% Watchdog ID
		{'process_id'}	 ... %% Process ID
		{'state'}		 ... %% Is running / finished / suspended / crashed
		{'muted'}		 ... %% Is muted
		{'pid'}			 ... %% PID
		{'crashes'}		 ... %% Number of crashes
		];
	byte = [ 2 2 1 1 4 2 ];
	type = [ {'uint16'} {'uint16'} {'uint8'} {'uint8'} {'int32'} {'uint16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

