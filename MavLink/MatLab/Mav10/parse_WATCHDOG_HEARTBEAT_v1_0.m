%%  case: 180
function S = parse_WATCHDOG_HEARTBEAT_v1_0(p)
	name = [ ...
		{'watchdog_id'}		 ... %% Watchdog ID
		{'process_count'}	 ... %% Number of processes
		];
	byte = [ 2 2 ];
	type = [ {'uint16'} {'uint16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

