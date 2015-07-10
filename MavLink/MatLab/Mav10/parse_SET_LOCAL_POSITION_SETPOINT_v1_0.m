%%  case: 50
%%~ Set the setpoint for a local position controller. This is the position in local 
%%~ coordinates the MAV should fly to. This message is sent by the path/MISSION planner 
%%~ to the onboard position controller. As some MAVs have a degree of freedom in 
%%~ yaw (e.g. all helicopters/quadrotors), the desired yaw angle is part of the message.
function S = parse_SET_LOCAL_POSITION_SETPOINT_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'coordinate_frame'} ... %% Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
		{'x'}				 ... %% x position
		{'y'}				 ... %% y position
		{'z'}				 ... %% z position
		{'yaw'}				 ... %% Desired yaw angle
		];
	byte = [ 1 1 1 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

