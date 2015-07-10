%%  case: 100
%%~ Optical flow from a flow sensor (e.g. optical mouse sensor)
function S = parse_OPTICAL_FLOW_v1_0(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

