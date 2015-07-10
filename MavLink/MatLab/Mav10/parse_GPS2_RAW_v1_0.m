%%  case: 124
%%~ Second GPS data. Coordinate frame is right-handed, Z-axis up (GPS frame).
function S = parse_GPS2_RAW_v1_0(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

