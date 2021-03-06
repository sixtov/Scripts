%%  case: 100
%%~ Optical flow from a flow sensor (e.g. optical mouse sensor)
function p = encode_OPTICAL_FLOW_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(26);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(100);
	name = [ ...
		{'time_usec'}		 ... %% Timestamp (UNIX)
		{'sensor_id'}		 ... %% Sensor ID
		{'flow_x'}			 ... %% Flow in pixels * 10 in x-sensor direction (dezi-pixels)
		{'flow_y'}			 ... %% Flow in pixels * 10 in y-sensor direction (dezi-pixels)
		{'flow_comp_m_x'}	 ... %% Flow in meters in x-sensor direction, angular-speed compensated
		{'flow_comp_m_y'}	 ... %% Flow in meters in y-sensor direction, angular-speed compensated
		{'quality'}			 ... %% Optical flow quality / confidence. 0: bad, 255: maximum quality
		{'ground_distance'}	 ... %% Ground distance in meters. Positive value: distance known. Negative value: Unknown distance
		];
	byte = [ 8 1 2 2 4 4 1 4 ];
	type = [ {'uint64'} {'uint8'} {'int16'} {'int16'} {'single'} {'single'} {'uint8'} {'single'} ];

	p = [head len pnum sysid id messid];
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

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
