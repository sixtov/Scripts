%%  case: 32
%%~ The global position, as returned by the Global Positioning System (GPS). This is 
%%~ NOT the global position estimate of the sytem, but rather a RAW sensor value. See 
%%~ message GLOBAL_POSITION for the global position estimate. Coordinate frame is 
%%~ right-handed, Z-axis up (GPS frame)
function p = encode_GPS_RAW_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(37);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(32);
	name = [ ...
		{'usec'}	 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'fix_type'} ... %% 0-1: no fix, 2: 2D fix, 3: 3D fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
		{'lat'}		 ... %% Latitude in degrees
		{'lon'}		 ... %% Longitude in degrees
		{'alt'}		 ... %% Altitude in meters
		{'eph'}		 ... %% GPS HDOP
		{'epv'}		 ... %% GPS VDOP
		{'v'}		 ... %% GPS ground speed
		{'hdg'}		 ... %% Compass heading in degrees, 0..360 degrees
		];
	byte = [ 8 1 4 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode usec data field
	val = typecast(S.usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode fix_type data field
	val = typecast(S.fix_type,'uint8');
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

	%% Encode eph data field
	val = typecast(S.eph,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode epv data field
	val = typecast(S.epv,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode v data field
	val = typecast(S.v,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode hdg data field
	val = typecast(S.hdg,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
