%%%%  case: 23
%%~ Set a parameter value TEMPORARILY to RAM. It will be reset to default on system 
%%~ reboot. Send the ACTION MAV_ACTION_STORAGE_WRITE to PERMANENTLY write the RAM contents 
%%~ to EEPROM. IMPORTANT: The receiving component should acknowledge the new 
%%~ parameter value by sending a param_value message to all communication partners. 
%%~ This will also ensure that multiple GCS all have an up-to-date list of all parameters. 
%%~ If the sending GCS did not receive a PARAM_VALUE message within its timeout 
%%~ time, it should re-send the PARAM_SET message.
function p = encodeValues_PARAM_SET_v1_0(target_system,target_component,param_id,param_value,param_type)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.param_id = typecast(uint8(param_id),'uint8');		% Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
	S.param_value = typecast(single(param_value),'single');		% Onboard parameter value
	S.param_type = typecast(uint8(param_type),'uint8');		% Onboard parameter type: see the MAV_PARAM_TYPE enum for supported data types.
	p = encode_PARAM_SET_v1_0(S);
return
