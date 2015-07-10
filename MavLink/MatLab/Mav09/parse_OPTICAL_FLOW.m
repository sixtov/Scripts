%%  case: 100
%%~ Optical flow from a flow sensor (e.g. optical mouse sensor)
function S = parse_OPTICAL_FLOW(S,p)
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
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

