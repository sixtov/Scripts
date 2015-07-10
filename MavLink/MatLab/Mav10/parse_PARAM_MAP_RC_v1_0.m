%%  case: 50
%%~ Bind a RC channel to a parameter. The parameter should change accoding to the RC 
%%~ channel value.
function S = parse_PARAM_MAP_RC_v1_0(p)
	name = [ ...
		{'target_system'}				 ... %% System ID
		{'target_component'}			 ... %% Component ID
		{'param_id'}					 ... %% Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
		{'param_index'}					 ... %% Parameter index. Send -1 to use the param ID field as identifier (else the param id will be ignored), send -2 to disable any existing map for this rc_channel_index.
		{'parameter_rc_channel_index'}	 ... %% Index of parameter RC channel. Not equal to the RC channel id. Typically correpsonds to a potentiometer-knob on the RC.
		{'param_value0'}				 ... %% Initial parameter value
		{'scale'}						 ... %% Scale, maps the RC range [-1, 1] to a parameter value
		{'param_value_min'}				 ... %% Minimum param value. The protocol does not define if this overwrites an onboard minimum value. (Depends on implementation)
		{'param_value_max'}				 ... %% Maximum param value. The protocol does not define if this overwrites an onboard maximum value. (Depends on implementation)
		];
	byte = [ 1 1 16 2 1 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'int16'} {'uint8'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

