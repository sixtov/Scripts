%%  case: 77
%%~ Report status of a command. Includes feedback wether the command was executed.
function p = encode_COMMAND_ACK(S)
	name = [ ...
		{'command'}	 ... %% Command ID, as defined by MAV_CMD enum.
		{'result'}	 ... %% See MAV_RESULT enum
		];
	byte = [ 2 1 ];
	type = [ {'uint16'} {'uint8'} ];

	%% Encode command data field
	val = typecast(S.command,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode result data field
	val = typecast(S.result,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
