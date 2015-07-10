%%  case: 183
function S = parse_WATCHDOG_COMMAND_v1_0(p)
	name = [ ...
		{'target_system_id'} ... %% Target system ID
		{'watchdog_id'}		 ... %% Watchdog ID
		{'process_id'}		 ... %% Process ID
		{'command_id'}		 ... %% Command ID
		];
	byte = [ 1 2 2 1 ];
	type = [ {'uint8'} {'uint16'} {'uint16'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

