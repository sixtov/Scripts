%%  case: 33
%%~ The filtered global position (e.g. fused GPS and accelerometers). The position is 
%%~ in GPS-frame (right-handed, Z-up). It                is designed as scaled integer 
%%~ message since the resolution of float is not sufficient.
function p = encode_GLOBAL_POSITION_INT_v1_0(S)
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
	messid = uint8(33);
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'lat'}			 ... %% Latitude, expressed as * 1E7
		{'lon'}			 ... %% Longitude, expressed as * 1E7
		{'alt'}			 ... %% Altitude in meters, expressed as * 1000 (millimeters), AMSL (not WGS84 - note that virtually all GPS modules provide the AMSL as well)
		{'relative_alt'} ... %% Altitude above ground in meters, expressed as * 1000 (millimeters)
		{'vx'}			 ... %% Ground X Speed (Latitude), expressed as m/s * 100
		{'vy'}			 ... %% Ground Y Speed (Longitude), expressed as m/s * 100
		{'vz'}			 ... %% Ground Z Speed (Altitude), expressed as m/s * 100
		{'hdg'}			 ... %% Compass heading in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX
		];
	byte = [ 4 4 4 4 4 2 2 2 2 ];
	type = [ {'uint32'} {'int32'} {'int32'} {'int32'} {'int32'} {'int16'} {'int16'} {'int16'} {'uint16'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
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
	val = typecast(S.vx,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vy data field
	val = typecast(S.vy,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vz data field
	val = typecast(S.vz,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode hdg data field
	val = typecast(S.hdg,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
