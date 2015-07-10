%%  case: 50
%%~ Bind a RC channel to a parameter. The parameter should change accoding to the RC 
%%~ channel value.
function p = encode_PARAM_MAP_RC_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(37);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(50);
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

	%% Encode param_index data field
	val = typecast(S.param_index,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode parameter_rc_channel_index data field
	val = typecast(S.parameter_rc_channel_index,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param_value0 data field
	val = typecast(S.param_value0,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode scale data field
	val = typecast(S.scale,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param_value_min data field
	val = typecast(S.param_value_min,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param_value_max data field
	val = typecast(S.param_value_max,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
