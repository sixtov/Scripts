%%  case: 52
%%~ Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
%%~ and to the GCS.
function p = encode_GLOBAL_POSITION_SETPOINT_INT(S)
	name = [ ...
		{'coordinate_frame'} ... %% Coordinate frame - valid values are only MAV_FRAME_GLOBAL or MAV_FRAME_GLOBAL_RELATIVE_ALT
		{'latitude'}		 ... %% Latitude (WGS84), in degrees * 1E7
		{'longitude'}		 ... %% Longitude (WGS84), in degrees * 1E7
		{'altitude'}		 ... %% Altitude (WGS84), in meters * 1000 (positive for up)
		{'yaw'}				 ... %% Desired yaw angle in degrees * 100
		];
	byte = [ 1 4 4 4 2 ];
	type = [ {'uint8'} {'int32'} {'int32'} {'int32'} {'int16'} ];

	%% Encode coordinate_frame data field
	val = typecast(S.coordinate_frame,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode latitude data field
	val = typecast(S.latitude,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode longitude data field
	val = typecast(S.longitude,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode altitude data field
	val = typecast(S.altitude,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yaw data field
	val = typecast(S.yaw,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
