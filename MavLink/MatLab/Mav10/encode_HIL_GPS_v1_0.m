%%  case: 113
%%~ The global position, as returned by the Global Positioning System (GPS). This is 
%%~                  NOT the global position estimate of the sytem, but rather a RAW 
%%~ sensor value. See message GLOBAL_POSITION for the global position estimate. Coordinate 
%%~ frame is right-handed, Z-axis up (GPS frame).
function p = encode_HIL_GPS_v1_0(S)
	name = [ ...
		{'time_usec'}			 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'fix_type'}			 ... %% 0-1: no fix, 2: 2D fix, 3: 3D fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
		{'lat'}					 ... %% Latitude (WGS84), in degrees * 1E7
		{'lon'}					 ... %% Longitude (WGS84), in degrees * 1E7
		{'alt'}					 ... %% Altitude (WGS84), in meters * 1000 (positive for up)
		{'eph'}					 ... %% GPS HDOP horizontal dilution of position in cm (m*100). If unknown, set to: 65535
		{'epv'}					 ... %% GPS VDOP vertical dilution of position in cm (m*100). If unknown, set to: 65535
		{'vel'}					 ... %% GPS ground speed (m/s * 100). If unknown, set to: 65535
		{'vn'}					 ... %% GPS velocity in cm/s in NORTH direction in earth-fixed NED frame
		{'ve'}					 ... %% GPS velocity in cm/s in EAST direction in earth-fixed NED frame
		{'vd'}					 ... %% GPS velocity in cm/s in DOWN direction in earth-fixed NED frame
		{'cog'}					 ... %% Course over ground (NOT heading, but direction of movement) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: 65535
		{'satellites_visible'}	 ... %% Number of satellites visible. If unknown, set to 255
		];
	byte = [ 8 1 4 4 4 2 2 2 2 2 2 2 1 ];
	type = [ {'uint64'} {'uint8'} {'int32'} {'int32'} {'int32'} {'uint16'} {'uint16'} {'uint16'} {'int16'} {'int16'} {'int16'} {'uint16'} {'uint8'} ];

	p = [];
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

	%% Encode vn data field
	val = typecast(S.vn,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ve data field
	val = typecast(S.ve,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vd data field
	val = typecast(S.vd,'int16');
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

return
