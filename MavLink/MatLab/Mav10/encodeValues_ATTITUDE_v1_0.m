%%%%  case: 30
%%~ The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right).
function p = encodeValues_ATTITUDE_v1_0(time_boot_ms,roll,pitch,yaw,rollspeed,pitchspeed,yawspeed)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp (milliseconds since system boot)
	S.roll = typecast(single(roll),'single');		% Roll angle (rad, -pi..+pi)
	S.pitch = typecast(single(pitch),'single');		% Pitch angle (rad, -pi..+pi)
	S.yaw = typecast(single(yaw),'single');		% Yaw angle (rad, -pi..+pi)
	S.rollspeed = typecast(single(rollspeed),'single');		% Roll angular speed (rad/s)
	S.pitchspeed = typecast(single(pitchspeed),'single');		% Pitch angular speed (rad/s)
	S.yawspeed = typecast(single(yawspeed),'single');		% Yaw angular speed (rad/s)
	p = encode_ATTITUDE_v1_0(S);
return
