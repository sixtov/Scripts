%%  case: 106
%%~ Optical flow from an omnidirectional flow sensor (e.g. PX4FLOW with wide angle lens)
function p = encode_OMNIDIRECTIONAL_FLOW_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(54);
	sysid = uint8(S.sysid);
	id = uint8(S.id);
	messid = uint8(106);
	name = [ ...
		{'time_usec'}		 ... %% Timestamp (microseconds, synced to UNIX time or since system boot)
		{'sensor_id'}		 ... %% Sensor ID
		{'left'}			 ... %% Flow in deci pixels (1 = 0.1 pixel) on left hemisphere
		{'right'}			 ... %% Flow in deci pixels (1 = 0.1 pixel) on right hemisphere
		{'quality'}			 ... %% Optical flow quality / confidence. 0: bad, 255: maximum quality
		{'front_distance_m'} ... %% Front distance in meters. Positive value (including zero): distance known. Negative value: Unknown distance
		];
	byte = [ 8 1 20 20 1 4 ];
	type = [ {'uint64'} {'uint8'} {'int16'} {'int16'} {'uint8'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_usec data field
	val = typecast(S.time_usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode sensor_id data field
	val = typecast(S.sensor_id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode left data field
	val = typecast(S.left,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode right data field
	val = typecast(S.right,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode quality data field
	val = typecast(S.quality,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode front_distance_m data field
	val = typecast(S.front_distance_m,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
