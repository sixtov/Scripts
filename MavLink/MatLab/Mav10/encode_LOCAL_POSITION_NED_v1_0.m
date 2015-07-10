%%  case: 32
%%~ The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
%%~ frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down 
%%~ convention)
function p = encode_LOCAL_POSITION_NED_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(28);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(32);
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'x'}			 ... %% X Position
		{'y'}			 ... %% Y Position
		{'z'}			 ... %% Z Position
		{'vx'}			 ... %% X Speed
		{'vy'}			 ... %% Y Speed
		{'vz'}			 ... %% Z Speed
		];
	byte = [ 4 4 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
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

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
