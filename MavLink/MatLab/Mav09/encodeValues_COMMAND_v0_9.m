%%%%  case: 75
%%~ Send a command with up to four parameters to the MAV
function p = encodeValues_COMMAND_v0_9(target_system,target_component,command,confirmation,param1,param2,param3,param4)
	S.target_system = typecast(uint8(target_system),'uint8');		% System which should execute the command
	S.target_component = typecast(uint8(target_component),'uint8');		% Component which should execute the command, 0 for all components
	S.command = typecast(uint8(command),'uint8');		% Command ID, as defined by MAV_CMD enum.
	S.confirmation = typecast(uint8(confirmation),'uint8');		% 0: First transmission of this command. 1-255: Confirmation transmissions (e.g. for kill command)
	S.param1 = typecast(single(param1),'single');		% Parameter 1, as defined by MAV_CMD enum.
	S.param2 = typecast(single(param2),'single');		% Parameter 2, as defined by MAV_CMD enum.
	S.param3 = typecast(single(param3),'single');		% Parameter 3, as defined by MAV_CMD enum.
	S.param4 = typecast(single(param4),'single');		% Parameter 4, as defined by MAV_CMD enum.
	p = encode_COMMAND_v0_9(S);
return
