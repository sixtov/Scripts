%%%%  case: 163
%%~ Status of DCM attitude estimator
function p = encodeValues_AHRS_v1_0(omegaIx,omegaIy,omegaIz,accel_weight,renorm_val,error_rp,error_yaw)
	S.omegaIx = typecast(single(omegaIx),'single');		% X gyro drift estimate rad/s
	S.omegaIy = typecast(single(omegaIy),'single');		% Y gyro drift estimate rad/s
	S.omegaIz = typecast(single(omegaIz),'single');		% Z gyro drift estimate rad/s
	S.accel_weight = typecast(single(accel_weight),'single');		% average accel_weight
	S.renorm_val = typecast(single(renorm_val),'single');		% average renormalisation value
	S.error_rp = typecast(single(error_rp),'single');		% average error_roll_pitch value
	S.error_yaw = typecast(single(error_yaw),'single');		% average error_yaw value
	p = encode_AHRS_v1_0(S);
return
