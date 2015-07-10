%%%%  case: 30
%%~ The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right).
function p = encodeValues_ATTITUDE_v0_9(usec,roll,pitch,yaw,rollspeed,pitchspeed,yawspeed)
	S.usec = typecast(uint64(usec),'uint64');		% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
	S.roll = typecast(single(roll),'single');		% Roll angle (rad)
	S.pitch = typecast(single(pitch),'single');		% Pitch angle (rad)
	S.yaw = typecast(single(yaw),'single');		% Yaw angle (rad)
	S.rollspeed = typecast(single(rollspeed),'single');		% Roll angular speed (rad/s)
	S.pitchspeed = typecast(single(pitchspeed),'single');		% Pitch angular speed (rad/s)
	S.yawspeed = typecast(single(yawspeed),'single');		% Yaw angular speed (rad/s)
	p = encode_ATTITUDE_v0_9(S);
return
