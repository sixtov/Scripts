%%  case: 100
%%~ Optical flow from a flow sensor (e.g. optical mouse sensor)
function p = encode_OPTICAL_FLOW_v0_9(S)
	name = [ ...
		{'time'}			 ... %% Timestamp (UNIX)
		{'sensor_id'}		 ... %% Sensor ID
		{'flow_x'}			 ... %% Flow in pixels in x-sensor direction
		{'flow_y'}			 ... %% Flow in pixels in y-sensor direction
		{'quality'}			 ... %% Optical flow quality / confidence. 0: bad, 255: maximum quality
		{'ground_distance'}	 ... %% Ground distance in meters
		];
	byte = [ 8 1 2 2 1 4 ];
	type = [ {'uint64'} {'uint8'} {'int16'} {'int16'} {'uint8'} {'single'} ];

	p = [];
	%% Encode time data field
	val = typecast(S.time,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode sensor_id data field
	val = typecast(S.sensor_id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode flow_x data field
	val = typecast(S.flow_x,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode flow_y data field
	val = typecast(S.flow_y,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode quality data field
	val = typecast(S.quality,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ground_distance data field
	val = typecast(S.ground_distance,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
