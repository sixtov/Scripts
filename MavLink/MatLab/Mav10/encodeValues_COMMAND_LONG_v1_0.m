%%%%  case: 76
%%~ Send a command with up to seven parameters to the MAV
function p = encodeValues_COMMAND_LONG_v1_0(target_system,target_component,command,confirmation,param1,param2,param3,param4,param5,param6,param7)
	S.target_system = typecast(uint8(target_system),'uint8');		% System which should execute the command
	S.target_component = typecast(uint8(target_component),'uint8');		% Component which should execute the command, 0 for all components
	S.command = typecast(uint16(command),'uint16');		% Command ID, as defined by MAV_CMD enum.
	S.confirmation = typecast(uint8(confirmation),'uint8');		% 0: First transmission of this command. 1-255: Confirmation transmissions (e.g. for kill command)
	S.param1 = typecast(single(param1),'single');		% Parameter 1, as defined by MAV_CMD enum.
	S.param2 = typecast(single(param2),'single');		% Parameter 2, as defined by MAV_CMD enum.
	S.param3 = typecast(single(param3),'single');		% Parameter 3, as defined by MAV_CMD enum.
	S.param4 = typecast(single(param4),'single');		% Parameter 4, as defined by MAV_CMD enum.
	S.param5 = typecast(single(param5),'single');		% Parameter 5, as defined by MAV_CMD enum.
	S.param6 = typecast(single(param6),'single');		% Parameter 6, as defined by MAV_CMD enum.
	S.param7 = typecast(single(param7),'single');		% Parameter 7, as defined by MAV_CMD enum.
	p = encode_COMMAND_LONG_v1_0(S);
return
