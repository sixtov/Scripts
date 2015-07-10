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
		{'param_id'}		 ... %% Onboard parameter id
		{'param_value'}		 ... %% Onboard parameter value
		];
	byte = [ 1 1 15 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

