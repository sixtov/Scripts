%%  case: 33
%%~ The filtered global position (e.g. fused GPS and accelerometers). Coordinate frame 
%%~ is right-handed, Z-axis up (GPS frame)
function p = encode_GLOBAL_POSITION_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(32);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(33);
	name = [ ...
		{'usec'} ... %% Timestamp (microseconds since unix epoch)
		{'lat'}	 ... %% Latitude, in degrees
		{'lon'}	 ... %% Longitude, in degrees
		{'alt'}	 ... %% Absolute altitude, in meters
		{'vx'}	 ... %% X Speed (in Latitude direction, positive: going north)
		{'vy'}	 ... %% Y Speed (in Longitude direction, positive: going east)
		{'vz'}	 ... %% Z Speed (in Altitude direction, positive: going up)
		];
	byte = [ 8 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode usec data field
	val = typecast(S.usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lat data field
	val = typecast(S.lat,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lon data field
	val = typecast(S.lon,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode alt data field
	val = typecast(S.alt,'single');
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

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
