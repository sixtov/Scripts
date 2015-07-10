%%  case: 154
%%~ Configure on-board Camera Control System.
function p = encode_DIGICAM_CONFIGURE(S)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'mode'}			 ... %% Mode enumeration from 1 to N //P, TV, AV, M, Etc (0 means ignore)
		{'shutter_speed'}	 ... %% Divisor number //e.g. 1000 means 1/1000 (0 means ignore)
		{'aperture'}		 ... %% F stop number x 10 //e.g. 28 means 2.8 (0 means ignore)
		{'iso'}				 ... %% ISO enumeration from 1 to N //e.g. 80, 100, 200, Etc (0 means ignore)
		{'exposure_type'}	 ... %% Exposure type enumeration from 1 to N (0 means ignore)
		{'command_id'}		 ... %% Command Identity (incremental loop: 0 to 255)//A command sent multiple times will be executed or pooled just once
		{'engine_cut_off'}	 ... %% Main engine cut-off time before camera trigger in seconds/10 (0 means no cut-off)
		{'extra_param'}		 ... %% Extra parameters enumeration (0 means ignore)
		{'extra_value'}		 ... %% Correspondent value to given extra_param
		];
	byte = [ 1 1 1 2 1 1 1 1 1 1 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'single'} ];

	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mode data field
	val = typecast(S.mode,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode shutter_speed data field
	val = typecast(S.shutter_speed,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode aperture data field
	val = typecast(S.aperture,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode iso data field
	val = typecast(S.iso,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode exposure_type data field
	val = typecast(S.exposure_type,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode command_id data field
	val = typecast(S.command_id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode engine_cut_off data field
	val = typecast(S.engine_cut_off,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode extra_param data field
	val = typecast(S.extra_param,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode extra_value data field
	val = typecast(S.extra_value,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
