%%%%  case: 22
%%~ Emit the value of a onboard parameter. The inclusion of param_count and param_index 
%%~ in the message allows the recipient to keep track of received parameters and 
%%~ allows him to re-request missing parameters after a loss or timeout.
function p = encodeValues_PARAM_VALUE_v1_0(param_id,param_value,param_type,param_count,param_index)
	S.param_id = typecast(uint8(param_id),'uint8');		% Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
	S.param_value = typecast(single(param_value),'single');		% Onboard parameter value
	S.param_type = typecast(uint8(param_type),'uint8');		% Onboard parameter type: see the MAV_PARAM_TYPE enum for supported data types.
	S.param_count = typecast(uint16(param_count),'uint16');		% Total number of onboard parameters
	S.param_index = typecast(uint16(param_index),'uint16');		% Index of this onboard parameter
	p = encode_PARAM_VALUE_v1_0(S);
return
