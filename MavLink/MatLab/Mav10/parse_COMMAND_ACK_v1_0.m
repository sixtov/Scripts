%%  case: 77
%%~ Report status of a command. Includes feedback wether the command was executed.
function S = parse_COMMAND_ACK_v1_0(p)
	name = [ ...
		{'command'}	 ... %% Command ID, as defined by MAV_CMD enum.
		{'result'}	 ... %% See MAV_RESULT enum
		];
	byte = [ 2 1 ];
	type = [ {'uint16'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

