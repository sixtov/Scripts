%%  case: 51
%%~ Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
%%~ and to the GCS.
function p = encode_LOCAL_POSITION_SETPOINT(S)
	name = [ ...
		{'coordinate_frame'} ... %% Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
		{'x'}				 ... %% x position
		{'y'}				 ... %% y position
		{'z'}				 ... %% z position
		{'yaw'}				 ... %% Desired yaw angle
		];
	byte = [ 1 4 4 4 4 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} ];

	%% Encode coordinate_frame data field
	val = typecast(S.coordinate_frame,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode x data field
	val = typecast(S.x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode y data field
	val = typecast(S.y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode z data field
	val = typecast(S.z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yaw data field
	val = typecast(S.yaw,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
