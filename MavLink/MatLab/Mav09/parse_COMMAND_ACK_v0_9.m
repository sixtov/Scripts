%%  case: 76
%%~ Report status of a command. Includes feedback wether the command was executed
function S = parse_COMMAND_ACK_v0_9(p)
	name = [ ...
		{'command'}	 ... %% Current airspeed in m/s
		{'result'}	 ... %% 1: Action ACCEPTED and EXECUTED, 1: Action TEMPORARY REJECTED/DENIED, 2: Action PERMANENTLY DENIED, 3: Action UNKNOWN/UNSUPPORTED, 4: Requesting CONFIRMATION
		];
	byte = [ 4 4 ];
	type = [ {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

