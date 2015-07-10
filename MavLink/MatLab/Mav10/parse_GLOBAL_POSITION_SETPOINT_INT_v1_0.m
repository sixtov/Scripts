%%  case: 52
%%~ Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
%%~ and to the GCS.
function S = parse_GLOBAL_POSITION_SETPOINT_INT_v1_0(p)
	name = [ ...
		{'coordinate_frame'} ... %% Coordinate frame - valid values are only MAV_FRAME_GLOBAL or MAV_FRAME_GLOBAL_RELATIVE_ALT
		{'latitude'}		 ... %% Latitude (WGS84), in degrees * 1E7
		{'longitude'}		 ... %% Longitude (WGS84), in degrees * 1E7
		{'altitude'}		 ... %% Altitude (WGS84), in meters * 1000 (positive for up)
		{'yaw'}				 ... %% Desired yaw angle in degrees * 100
		];
	byte = [ 1 4 4 4 2 ];
	type = [ {'uint8'} {'int32'} {'int32'} {'int32'} {'int16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

