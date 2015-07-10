%%  case: 114
%%~ Simulated optical flow from a flow sensor (e.g. PX4FLOW or optical mouse sensor)
function p = encode_HIL_OPTICAL_FLOW_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(44);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(114);
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

	p = [head len pnum sysid id messid];
	%% Encode time_usec data field
	val = typecast(S.time_usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode sensor_id data field
	val = typecast(S.sensor_id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode integration_time_us data field
	val = typecast(S.integration_time_us,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode integrated_x data field
	val = typecast(S.integrated_x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode integrated_y data field
	val = typecast(S.integrated_y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode integrated_xgyro data field
	val = typecast(S.integrated_xgyro,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode integrated_ygyro data field
	val = typecast(S.integrated_ygyro,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode integrated_zgyro data field
	val = typecast(S.integrated_zgyro,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode temperature data field
	val = typecast(S.temperature,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode quality data field
	val = typecast(S.quality,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode time_delta_distance_us data field
	val = typecast(S.time_delta_distance_us,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode distance data field
	val = typecast(S.distance,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
