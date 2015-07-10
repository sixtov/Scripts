%%  case: 132
function p = encode_DISTANCE_SENSOR_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(14);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(132);
	name = [ ...
		{'time_boot_ms'}	 ... %% Time since system boot
		{'min_distance'}	 ... %% Minimum distance the sensor can measure in centimeters
		{'max_distance'}	 ... %% Maximum distance the sensor can measure in centimeters
		{'current_distance'} ... %% Current distance reading
		{'type'}			 ... %% Type from MAV_DISTANCE_SENSOR enum.
		{'id'}				 ... %% Onboard ID of the sensor
		{'orientation'}		 ... %% Direction the sensor faces from FIXME enum.
		{'covariance'}		 ... %% Measurement covariance in centimeters, 0 for unknown / invalid readings
		];
	byte = [ 4 2 2 2 1 1 1 1 ];
	type = [ {'uint32'} {'uint16'} {'uint16'} {'uint16'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode min_distance data field
	val = typecast(S.min_distance,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode max_distance data field
	val = typecast(S.max_distance,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode current_distance data field
	val = typecast(S.current_distance,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode type data field
	val = typecast(S.type,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode id data field
	val = typecast(S.id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode orientation data field
	val = typecast(S.orientation,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode covariance data field
	val = typecast(S.covariance,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
