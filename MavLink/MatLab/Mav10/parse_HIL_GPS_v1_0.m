%%  case: 113
%%~ The global position, as returned by the Global Positioning System (GPS). This is 
%%~                  NOT the global position estimate of the sytem, but rather a RAW 
%%~ sensor value. See message GLOBAL_POSITION for the global position estimate. Coordinate 
%%~ frame is right-handed, Z-axis up (GPS frame).
function S = parse_HIL_GPS_v1_0(S,p)
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
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

