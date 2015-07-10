%%%%  case: 51
%%~ Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
%%~ and to the GCS.
function p = encodeValues_LOCAL_POSITION_SETPOINT_v0_9(x,y,z,yaw)
	S.x = typecast(single(x),'single');		% x position
	S.y = typecast(single(y),'single');		% y position
	S.z = typecast(single(z),'single');		% z position
	S.yaw = typecast(single(yaw),'single');		% Desired yaw angle
	p = encode_LOCAL_POSITION_SETPOINT_v0_9(S);
return
