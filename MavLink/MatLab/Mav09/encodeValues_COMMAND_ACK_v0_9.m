%%%%  case: 76
%%~ Report status of a command. Includes feedback wether the command was executed
function p = encodeValues_COMMAND_ACK_v0_9(command,result)
	S.command = typecast(single(command),'single');		% Current airspeed in m/s
	S.result = typecast(single(result),'single');		% 1: Action ACCEPTED and EXECUTED, 1: Action TEMPORARY REJECTED/DENIED, 2: Action PERMANENTLY DENIED, 3: Action UNKNOWN/UNSUPPORTED, 4: Requesting CONFIRMATION
	p = encode_COMMAND_ACK_v0_9(S);
return
