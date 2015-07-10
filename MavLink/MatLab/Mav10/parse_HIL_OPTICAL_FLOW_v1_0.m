%%  case: 114
%%~ Simulated optical flow from a flow sensor (e.g. PX4FLOW or optical mouse sensor)
function S = parse_HIL_OPTICAL_FLOW_v1_0(p)
	name = [ ...
		{'time_usec'}				 ... %% Timestamp (microseconds, synced to UNIX time or since system boot)
		{'sensor_id'}				 ... %% Sensor ID
		{'integration_time_us'}		 ... %% Integration time in microseconds. Divide integrated_x and integrated_y by the integration time to obtain average flow. The integration time also indicates the.
		{'integrated_x'}			 ... %% Flow in radians around X axis (Sensor RH rotation about the X axis induces a positive flow. Sensor linear motion along the positive Y axis induces a negative flow.)
		{'integrated_y'}			 ... %% Flow in radians around Y axis (Sensor RH rotation about the Y axis induces a positive flow. Sensor linear motion along the positive X axis induces a positive flow.)
		{'integrated_xgyro'}		 ... %% RH rotation around X axis (rad)
		{'integrated_ygyro'}		 ... %% RH rotation around Y axis (rad)
		{'integrated_zgyro'}		 ... %% RH rotation around Z axis (rad)
		{'temperature'}				 ... %% Temperature * 100 in centi-degrees Celsius
		{'quality'}					 ... %% Optical flow quality / confidence. 0: no valid flow, 255: maximum quality
		{'time_delta_distance_us'}	 ... %% Time in microseconds since the distance was sampled.
		{'distance'}				 ... %% Distance to the center of the flow field in meters. Positive value (including zero): distance known. Negative value: Unknown distance.
		];
	byte = [ 8 1 4 4 4 4 4 4 2 1 4 4 ];
	type = [ {'uint64'} {'uint8'} {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'int16'} {'uint8'} {'uint32'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

