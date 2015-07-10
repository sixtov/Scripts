%%  case: 23
%%~ Set a parameter value TEMPORARILY to RAM. It will be reset to default on system 
%%~ reboot. Send the ACTION MAV_ACTION_STORAGE_WRITE to PERMANENTLY write the RAM contents 
%%~ to EEPROM. IMPORTANT: The receiving component should acknowledge the new 
%%~ parameter value by sending a param_value message to all communication partners. 
%%~ This will also ensure that multiple GCS all have an up-to-date list of all parameters. 
%%~ If the sending GCS did not receive a PARAM_VALUE message within its timeout 
%%~ time, it should re-send the PARAM_SET message.
function S = parse_PARAM_SET(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'param_id'}		 ... %% Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
		{'param_value'}		 ... %% Onboard parameter value
		{'param_type'}		 ... %% Onboard parameter type: see the MAV_PARAM_TYPE enum for supported data types.
		];
	byte = [ 1 1 16 4 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'single'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

