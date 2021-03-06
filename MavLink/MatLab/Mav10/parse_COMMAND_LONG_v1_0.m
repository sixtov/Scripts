%%  case: 76
%%~ Send a command with up to seven parameters to the MAV
function S = parse_COMMAND_LONG_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System which should execute the command
		{'target_component'} ... %% Component which should execute the command, 0 for all components
		{'command'}			 ... %% Command ID, as defined by MAV_CMD enum.
		{'confirmation'}	 ... %% 0: First transmission of this command. 1-255: Confirmation transmissions (e.g. for kill command)
		{'param1'}			 ... %% Parameter 1, as defined by MAV_CMD enum.
		{'param2'}			 ... %% Parameter 2, as defined by MAV_CMD enum.
		{'param3'}			 ... %% Parameter 3, as defined by MAV_CMD enum.
		{'param4'}			 ... %% Parameter 4, as defined by MAV_CMD enum.
		{'param5'}			 ... %% Parameter 5, as defined by MAV_CMD enum.
		{'param6'}			 ... %% Parameter 6, as defined by MAV_CMD enum.
		{'param7'}			 ... %% Parameter 7, as defined by MAV_CMD enum.
		];
	byte = [ 1 1 2 1 4 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

