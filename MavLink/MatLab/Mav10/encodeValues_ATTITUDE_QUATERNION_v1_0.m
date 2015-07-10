%%%%  case: 31
%%~ The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), 
%%~ expressed as quaternion.
function p = encodeValues_ATTITUDE_QUATERNION_v1_0(time_boot_ms,q1,q2,q3,q4,rollspeed,pitchspeed,yawspeed)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp (milliseconds since system boot)
	S.q1 = typecast(single(q1),'single');		% Quaternion component 1
	S.q2 = typecast(single(q2),'single');		% Quaternion component 2
	S.q3 = typecast(single(q3),'single');		% Quaternion component 3
	S.q4 = typecast(single(q4),'single');		% Quaternion component 4
	S.rollspeed = typecast(single(rollspeed),'single');		% Roll angular speed (rad/s)
	S.pitchspeed = typecast(single(pitchspeed),'single');		% Pitch angular speed (rad/s)
	S.yawspeed = typecast(single(yawspeed),'single');		% Yaw angular speed (rad/s)
	p = encode_ATTITUDE_QUATERNION_v1_0(S);
return
