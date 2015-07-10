%%  case: 23
%%~ Set a parameter value TEMPORARILY to RAM. It will be reset to default on system 
%%~ reboot. Send the ACTION MAV_ACTION_STORAGE_WRITE to PERMANENTLY write the RAM contents 
%%~ to EEPROM. IMPORTANT: The receiving component should acknowledge the new 
%%~ parameter value by sending a param_value message to all communication partners. 
%%~ This will also ensure that multiple GCS all have an up-to-date list of all parameters. 
%%~ If the sending GCS did not receive a PARAM_VALUE message within its timeout 
%%~ time, it should re-send the PARAM_SET message.
function p = encode_PARAM_SET_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(21);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(23);
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'param_id'}		 ... %% Onboard parameter id
		{'param_value'}		 ... %% Onboard parameter value
		];
	byte = [ 1 1 15 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'single'} ];

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

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
