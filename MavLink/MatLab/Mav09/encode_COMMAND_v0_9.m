%%  case: 75
%%~ Send a command with up to four parameters to the MAV
function p = encode_COMMAND_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(20);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(75);
	name = [ ...
		{'target_system'}	 ... %% System which should execute the command
		{'target_component'} ... %% Component which should execute the command, 0 for all components
		{'command'}			 ... %% Command ID, as defined by MAV_CMD enum.
		{'confirmation'}	 ... %% 0: First transmission of this command. 1-255: Confirmation transmissions (e.g. for kill command)
		{'param1'}			 ... %% Parameter 1, as defined by MAV_CMD enum.
		{'param2'}			 ... %% Parameter 2, as defined by MAV_CMD enum.
		{'param3'}			 ... %% Parameter 3, as defined by MAV_CMD enum.
		{'param4'}			 ... %% Parameter 4, as defined by MAV_CMD enum.
		];
	byte = [ 1 1 1 1 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode command data field
	val = typecast(S.command,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode confirmation data field
	val = typecast(S.confirmation,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param1 data field
	val = typecast(S.param1,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param2 data field
	val = typecast(S.param2,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param3 data field
	val = typecast(S.param3,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param4 data field
	val = typecast(S.param4,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
