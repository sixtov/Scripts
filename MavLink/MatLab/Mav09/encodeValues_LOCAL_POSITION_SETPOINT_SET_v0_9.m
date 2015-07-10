%%%%  case: 50
%%~ Set the setpoint for a local position controller. This is the position in local 
%%~ coordinates the MAV should fly to. This message is sent by the path/waypoint planner 
%%~ to the onboard position controller. As some MAVs have a degree of freedom in 
%%~ yaw (e.g. all helicopters/quadrotors), the desired yaw angle is part of the message.
function p = encodeValues_LOCAL_POSITION_SETPOINT_SET_v0_9(target_system,target_component,x,y,z,yaw)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.x = typecast(single(x),'single');		% x position
	S.y = typecast(single(y),'single');		% y position
	S.z = typecast(single(z),'single');		% z position
	S.yaw = typecast(single(yaw),'single');		% Desired yaw angle
	p = encode_LOCAL_POSITION_SETPOINT_SET_v0_9(S);
return
