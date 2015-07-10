%%  case: 23
%%~ Set a parameter value TEMPORARILY to RAM. It will be reset to default on system 
%%~ reboot. Send the ACTION MAV_ACTION_STORAGE_WRITE to PERMANENTLY write the RAM contents 
%%~ to EEPROM. IMPORTANT: The receiving component should acknowledge the new 
%%~ parameter value by sending a param_value message to all communication partners. 
%%~ This will also ensure that multiple GCS all have an up-to-date list of all parameters. 
%%~ If the sending GCS did not receive a PARAM_VALUE message within its timeout 
%%~ time, it should re-send the PARAM_SET message.
function p = encode_PARAM_SET_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(23);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(23);
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'param_id'}		 ... %% Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
		{'param_value'}		 ... %% Onboard parameter value
		{'param_type'}		 ... %% Onboard parameter type: see the MAV_PARAM_TYPE enum for supported data types.
		];
	byte = [ 1 1 16 4 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'single'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param_id data field
	val = typecast(S.param_id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param_value data field
	val = typecast(S.param_value,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param_type data field
	val = typecast(S.param_type,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
