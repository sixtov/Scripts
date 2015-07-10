%%%%  case: 51
%%~ Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
%%~ and to the GCS.
function p = encodeValues_LOCAL_POSITION_SETPOINT_v1_0(coordinate_frame,x,y,z,yaw)
	S.coordinate_frame = typecast(uint8(coordinate_frame),'uint8');		% Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
	S.x = typecast(single(x),'single');		% x position
	S.y = typecast(single(y),'single');		% y position
	S.z = typecast(single(z),'single');		% z position
	S.yaw = typecast(single(yaw),'single');		% Desired yaw angle
	p = encode_LOCAL_POSITION_SETPOINT_v1_0(S);
return
