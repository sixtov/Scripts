%%  case: 77
%%~ Report status of a command. Includes feedback wether the command was executed.
function S = parse_COMMAND_ACK_v1_0(S,p)
	name = [ ...
		{'command'}	 ... %% Command ID, as defined by MAV_CMD enum.
		{'result'}	 ... %% See MAV_RESULT enum
		];
	byte = [ 2 1 ];
	type = [ {'uint16'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

