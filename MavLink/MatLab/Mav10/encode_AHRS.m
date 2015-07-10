%%  case: 163
%%~ Status of DCM attitude estimator
function p = encode_AHRS(S)
	name = [ ...
		{'omegaIx'}		 ... %% X gyro drift estimate rad/s
		{'omegaIy'}		 ... %% Y gyro drift estimate rad/s
		{'omegaIz'}		 ... %% Z gyro drift estimate rad/s
		{'accel_weight'} ... %% average accel_weight
		{'renorm_val'}	 ... %% average renormalisation value
		{'error_rp'}	 ... %% average error_roll_pitch value
		{'error_yaw'}	 ... %% average error_yaw value
		];
	byte = [ 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	%% Encode omegaIx data field
	val = typecast(S.omegaIx,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode omegaIy data field
	val = typecast(S.omegaIy,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode omegaIz data field
	val = typecast(S.omegaIz,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode accel_weight data field
	val = typecast(S.accel_weight,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode renorm_val data field
	val = typecast(S.renorm_val,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode error_rp data field
	val = typecast(S.error_rp,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode error_yaw data field
	val = typecast(S.error_yaw,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
