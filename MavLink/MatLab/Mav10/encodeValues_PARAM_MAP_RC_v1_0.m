%%%%  case: 50
%%~ Bind a RC channel to a parameter. The parameter should change accoding to the RC 
%%~ channel value.
function p = encodeValues_PARAM_MAP_RC_v1_0(target_system,target_component,param_id,param_index,parameter_rc_channel_index,param_value0,scale,param_value_min,param_value_max)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.param_id = typecast(uint8(param_id),'uint8');		% Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
	S.param_index = typecast(int16(param_index),'int16');		% Parameter index. Send -1 to use the param ID field as identifier (else the param id will be ignored), send -2 to disable any existing map for this rc_channel_index.
	S.parameter_rc_channel_index = typecast(uint8(parameter_rc_channel_index),'uint8');		% Index of parameter RC channel. Not equal to the RC channel id. Typically correpsonds to a potentiometer-knob on the RC.
	S.param_value0 = typecast(single(param_value0),'single');		% Initial parameter value
	S.scale = typecast(single(scale),'single');		% Scale, maps the RC range [-1, 1] to a parameter value
	S.param_value_min = typecast(single(param_value_min),'single');		% Minimum param value. The protocol does not define if this overwrites an onboard minimum value. (Depends on implementation)
	S.param_value_max = typecast(single(param_value_max),'single');		% Maximum param value. The protocol does not define if this overwrites an onboard maximum value. (Depends on implementation)
	p = encode_PARAM_MAP_RC_v1_0(S);
return
