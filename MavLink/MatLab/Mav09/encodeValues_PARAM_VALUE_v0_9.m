%%%%  case: 22
%%~ Emit the value of a onboard parameter. The inclusion of param_count and param_index 
%%~ in the message allows the recipient to keep track of received parameters and 
%%~ allows him to re-request missing parameters after a loss or timeout.
function p = encodeValues_PARAM_VALUE_v0_9(param_id,param_value,param_count,param_index)
	S.param_id = typecast(uint8(param_id),'uint8');		% Onboard parameter id
	S.param_value = typecast(single(param_value),'single');		% Onboard parameter value
	S.param_count = typecast(uint16(param_count),'uint16');		% Total number of onboard parameters
	S.param_index = typecast(uint16(param_index),'uint16');		% Index of this onboard parameter
	p = encode_PARAM_VALUE_v0_9(S);
return
