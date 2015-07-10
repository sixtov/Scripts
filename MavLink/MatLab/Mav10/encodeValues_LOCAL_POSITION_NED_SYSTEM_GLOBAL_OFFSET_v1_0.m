%%%%  case: 89
%%~ The offset in X, Y, Z and yaw between the LOCAL_POSITION_NED messages of MAV X and 
%%~ the global coordinate frame in NED coordinates. Coordinate frame is right-handed, 
%%~ Z-axis down (aeronautical frame, NED / north-east-down convention)
function p = encodeValues_LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET_v1_0(time_boot_ms,x,y,z,roll,pitch,yaw)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp (milliseconds since system boot)
	S.x = typecast(single(x),'single');		% X Position
	S.y = typecast(single(y),'single');		% Y Position
	S.z = typecast(single(z),'single');		% Z Position
	S.roll = typecast(single(roll),'single');		% Roll
	S.pitch = typecast(single(pitch),'single');		% Pitch
	S.yaw = typecast(single(yaw),'single');		% Yaw
	p = encode_LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET_v1_0(S);
return
