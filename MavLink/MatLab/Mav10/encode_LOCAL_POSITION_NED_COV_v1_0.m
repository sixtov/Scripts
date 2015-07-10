%%  case: 64
%%~ The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
%%~ frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down 
%%~ convention)
function p = encode_LOCAL_POSITION_NED_COV_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(181);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(64);
	name = [ ...
		{'time_boot_ms'}	 ... %% Timestamp (milliseconds since system boot)
		{'time_utc'}		 ... %% Timestamp (microseconds since UNIX epoch) in UTC. 0 for unknown. Commonly filled by the precision time source of a GPS receiver.
		{'estimator_type'}	 ... %% Class id of the estimator this estimate originated from.
		{'x'}				 ... %% X Position
		{'y'}				 ... %% Y Position
		{'z'}				 ... %% Z Position
		{'vx'}				 ... %% X Speed
		{'vy'}				 ... %% Y Speed
		{'vz'}				 ... %% Z Speed
		{'covariance'}		 ... %% Covariance matrix (first six entries are the first ROW, next six entries are the second row, etc.)
		];
	byte = [ 4 8 1 4 4 4 4 4 4 144 ];
	type = [ {'uint32'} {'uint64'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

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

	%% Encode x data field
	val = typecast(S.x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode y data field
	val = typecast(S.y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode z data field
	val = typecast(S.z,'single');
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
