%%  case: 148
%%~ Set the 8 DOF setpoint for a controller.
function p = encode_SETPOINT_8DOF(S)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'val1'}			 ... %% Value 1
		{'val2'}			 ... %% Value 2
		{'val3'}			 ... %% Value 3
		{'val4'}			 ... %% Value 4
		{'val5'}			 ... %% Value 5
		{'val6'}			 ... %% Value 6
		{'val7'}			 ... %% Value 7
		{'val8'}			 ... %% Value 8
		];
	byte = [ 1 4 4 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode val1 data field
	val = typecast(S.val1,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode val2 data field
	val = typecast(S.val2,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode val3 data field
	val = typecast(S.val3,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode val4 data field
	val = typecast(S.val4,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode val5 data field
	val = typecast(S.val5,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode val6 data field
	val = typecast(S.val6,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode val7 data field
	val = typecast(S.val7,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode val8 data field
	val = typecast(S.val8,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
