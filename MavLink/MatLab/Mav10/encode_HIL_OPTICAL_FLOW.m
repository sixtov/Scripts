%%  case: 114
%%~ Simulated optical flow from a flow sensor (e.g. optical mouse sensor)
function p = encode_HIL_OPTICAL_FLOW(S)
	name = [ ...
		{'time_usec'}		 ... %% Timestamp (UNIX)
		{'sensor_id'}		 ... %% Sensor ID
		{'flow_x'}			 ... %% Flow in pixels in x-sensor direction
		{'flow_y'}			 ... %% Flow in pixels in y-sensor direction
		{'flow_comp_m_x'}	 ... %% Flow in meters in x-sensor direction, angular-speed compensated
		{'flow_comp_m_y'}	 ... %% Flow in meters in y-sensor direction, angular-speed compensated
		{'quality'}			 ... %% Optical flow quality / confidence. 0: bad, 255: maximum quality
		{'ground_distance'}	 ... %% Ground distance in meters. Positive value: distance known. Negative value: Unknown distance
		];
	byte = [ 8 1 2 2 4 4 1 4 ];
	type = [ {'uint64'} {'uint8'} {'int16'} {'int16'} {'single'} {'single'} {'uint8'} {'single'} ];

	%% Encode time_usec data field
	val = typecast(S.time_usec,'uint64');
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

	%% Encode flow_comp_m_x data field
	val = typecast(S.flow_comp_m_x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode flow_comp_m_y data field
	val = typecast(S.flow_comp_m_y,'single');
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
