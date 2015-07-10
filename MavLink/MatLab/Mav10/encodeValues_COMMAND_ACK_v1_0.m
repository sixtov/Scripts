%%%%  case: 77
%%~ Report status of a command. Includes feedback wether the command was executed.
function p = encodeValues_COMMAND_ACK_v1_0(command,result)
	S.command = typecast(uint16(command),'uint16');		% Command ID, as defined by MAV_CMD enum.
	S.result = typecast(uint8(result),'uint8');		% See MAV_RESULT enum
	p = encode_COMMAND_ACK_v1_0(S);
return
