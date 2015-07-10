%%  case: 149
%%~ Set the 6 DOF setpoint for a attitude and position controller.
function p = encode_SETPOINT_6DOF(S)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'trans_x'}			 ... %% Translational Component in x
		{'trans_y'}			 ... %% Translational Component in y
		{'trans_z'}			 ... %% Translational Component in z
		{'rot_x'}			 ... %% Rotational Component in x
		{'rot_y'}			 ... %% Rotational Component in y
		{'rot_z'}			 ... %% Rotational Component in z
		];
	byte = [ 1 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode trans_x data field
	val = typecast(S.trans_x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode trans_y data field
	val = typecast(S.trans_y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode trans_z data field
	val = typecast(S.trans_z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode rot_x data field
	val = typecast(S.rot_x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode rot_y data field
	val = typecast(S.rot_y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode rot_z data field
	val = typecast(S.rot_z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
