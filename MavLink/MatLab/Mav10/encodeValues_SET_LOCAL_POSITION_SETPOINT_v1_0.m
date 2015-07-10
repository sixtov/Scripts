%%%%  case: 50
%%~ Set the setpoint for a local position controller. This is the position in local 
%%~ coordinates the MAV should fly to. This message is sent by the path/MISSION planner 
%%~ to the onboard position controller. As some MAVs have a degree of freedom in 
%%~ yaw (e.g. all helicopters/quadrotors), the desired yaw angle is part of the message.
function p = encodeValues_SET_LOCAL_POSITION_SETPOINT_v1_0(target_system,target_component,coordinate_frame,x,y,z,yaw)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.coordinate_frame = typecast(uint8(coordinate_frame),'uint8');		% Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
	S.x = typecast(single(x),'single');		% x position
	S.y = typecast(single(y),'single');		% y position
	S.z = typecast(single(z),'single');		% z position
	S.yaw = typecast(single(yaw),'single');		% Desired yaw angle
	p = encode_SET_LOCAL_POSITION_SETPOINT_v1_0(S);
return
