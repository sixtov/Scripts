%%%%  case: 61
%%~ The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), 
%%~ expressed as quaternion. Quaternion order is w, x, y, z and a zero rotation would 
%%~ be expressed as (1 0 0 0).
function p = encodeValues_ATTITUDE_QUATERNION_COV_v1_0(time_boot_ms,q,rollspeed,pitchspeed,yawspeed,covariance)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp (milliseconds since system boot)
	S.q = typecast(single(q),'single');		% Quaternion components, w, x, y, z (1 0 0 0 is the null-rotation)
	S.rollspeed = typecast(single(rollspeed),'single');		% Roll angular speed (rad/s)
	S.pitchspeed = typecast(single(pitchspeed),'single');		% Pitch angular speed (rad/s)
	S.yawspeed = typecast(single(yawspeed),'single');		% Yaw angular speed (rad/s)
	S.covariance = typecast(single(covariance),'single');		% Attitude covariance
	p = encode_ATTITUDE_QUATERNION_COV_v1_0(S);
return
