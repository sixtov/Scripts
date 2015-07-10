%%  case: 63
%%~ The filtered global position (e.g. fused GPS and accelerometers). The position is 
%%~ in GPS-frame (right-handed, Z-up). It  is designed as scaled integer message since 
%%~ the resolution of float is not sufficient. NOTE: This message is intended for 
%%~ onboard networks / companion computers and higher-bandwidth links and optimized 
%%~ for accuracy and completeness. Please use the GLOBAL_POSITION_INT message for 
%%~ a minimal subset.
function p = encode_GLOBAL_POSITION_INT_COV_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(185);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(63);
	name = [ ...
		{'time_boot_ms'}	 ... %% Timestamp (milliseconds since system boot)
		{'time_utc'}		 ... %% Timestamp (microseconds since UNIX epoch) in UTC. 0 for unknown. Commonly filled by the precision time source of a GPS receiver.
		{'estimator_type'}	 ... %% Class id of the estimator this estimate originated from.
		{'lat'}				 ... %% Latitude, expressed as degrees * 1E7
		{'lon'}				 ... %% Longitude, expressed as degrees * 1E7
		{'alt'}				 ... %% Altitude in meters, expressed as * 1000 (millimeters), above MSL
		{'relative_alt'}	 ... %% Altitude above ground in meters, expressed as * 1000 (millimeters)
		{'vx'}				 ... %% Ground X Speed (Latitude), expressed as m/s
		{'vy'}				 ... %% Ground Y Speed (Longitude), expressed as m/s
		{'vz'}				 ... %% Ground Z Speed (Altitude), expressed as m/s
		{'covariance'}		 ... %% Covariance matrix (first six entries are the first ROW, next six entries are the second row, etc.)
		];
	byte = [ 4 8 1 4 4 4 4 4 4 4 144 ];
	type = [ {'uint32'} {'uint64'} {'uint8'} {'int32'} {'int32'} {'int32'} {'int32'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode time_utc data field
	val = typecast(S.time_utc,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode estimator_type data field
	val = typecast(S.estimator_type,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lat data field
	val = typecast(S.lat,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lon data field
	val = typecast(S.lon,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode alt data field
	val = typecast(S.alt,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode relative_alt data field
	val = typecast(S.relative_alt,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vx data field
	val = typecast(S.vx,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vy data field
	val = typecast(S.vy,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vz data field
	val = typecast(S.vz,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode covariance data field
	val = typecast(S.covariance,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
