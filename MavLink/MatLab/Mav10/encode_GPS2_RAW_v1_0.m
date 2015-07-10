%%  case: 124
%%~ Second GPS data. Coordinate frame is right-handed, Z-axis up (GPS frame).
function p = encode_GPS2_RAW_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(35);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(124);
	name = [ ...
		{'time_usec'}			 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'fix_type'}			 ... %% 0-1: no fix, 2: 2D fix, 3: 3D fix, 4: DGPS fix, 5: RTK Fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
		{'lat'}					 ... %% Latitude (WGS84), in degrees * 1E7
		{'lon'}					 ... %% Longitude (WGS84), in degrees * 1E7
		{'alt'}					 ... %% Altitude (AMSL, not WGS84), in meters * 1000 (positive for up)
		{'eph'}					 ... %% GPS HDOP horizontal dilution of position in cm (m*100). If unknown, set to: UINT16_MAX
		{'epv'}					 ... %% GPS VDOP vertical dilution of position in cm (m*100). If unknown, set to: UINT16_MAX
		{'vel'}					 ... %% GPS ground speed (m/s * 100). If unknown, set to: UINT16_MAX
		{'cog'}					 ... %% Course over ground (NOT heading, but direction of movement) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX
		{'satellites_visible'}	 ... %% Number of satellites visible. If unknown, set to 255
		{'dgps_numch'}			 ... %% Number of DGPS satellites
		{'dgps_age'}			 ... %% Age of DGPS info
		];
	byte = [ 8 1 4 4 4 2 2 2 2 1 1 4 ];
	type = [ {'uint64'} {'uint8'} {'int32'} {'int32'} {'int32'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint8'} {'uint8'} {'uint32'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_usec data field
	val = typecast(S.time_usec,'uint64');
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
	val = typecast(S.eph,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode epv data field
	val = typecast(S.epv,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vel data field
	val = typecast(S.vel,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode cog data field
	val = typecast(S.cog,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode satellites_visible data field
	val = typecast(S.satellites_visible,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode dgps_numch data field
	val = typecast(S.dgps_numch,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode dgps_age data field
	val = typecast(S.dgps_age,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
