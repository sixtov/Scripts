%%  case: 25
%%~ The global position, as returned by the Global Positioning System (GPS). This is 
%%~ NOT the global position estimate of the sytem, but rather a RAW sensor value. See 
%%~ message GLOBAL_POSITION for the global position estimate. Coordinate frame is 
%%~ right-handed, Z-axis up (GPS frame)
function p = encode_GPS_RAW_INT_v0_9(S)
	name = [ ...
		{'usec'}	 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'fix_type'} ... %% 0-1: no fix, 2: 2D fix, 3: 3D fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
		{'lat'}		 ... %% Latitude in 1E7 degrees
		{'lon'}		 ... %% Longitude in 1E7 degrees
		{'alt'}		 ... %% Altitude in 1E3 meters (millimeters)
		{'eph'}		 ... %% GPS HDOP
		{'epv'}		 ... %% GPS VDOP
		{'v'}		 ... %% GPS ground speed (m/s)
		{'hdg'}		 ... %% Compass heading in degrees, 0..360 degrees
		];
	byte = [ 8 1 4 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'uint8'} {'int32'} {'int32'} {'int32'} {'single'} {'single'} {'single'} {'single'} ];

	p = [];
	%% Encode usec data field
	val = typecast(S.usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode fix_type data field
	val = typecast(S.fix_type,'uint8');
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

return
