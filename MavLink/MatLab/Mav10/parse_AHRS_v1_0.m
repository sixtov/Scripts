%%  case: 163
%%~ Status of DCM attitude estimator
function S = parse_AHRS_v1_0(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

