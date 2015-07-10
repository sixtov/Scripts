%%  case: 117
%%~ Request a list of available logs. On some systems calling this may stop on-board 
%%~ logging until LOG_REQUEST_END is called.
function S = parse_LOG_REQUEST_LIST_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'start'}			 ... %% First log id (0 for first available)
		{'end'}				 ... %% Last log id (0xffff for last available)
		];
	byte = [ 1 1 2 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

