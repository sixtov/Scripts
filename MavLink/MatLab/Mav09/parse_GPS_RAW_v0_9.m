%%  case: 32
%%~ The global position, as returned by the Global Positioning System (GPS). This is 
%%~ NOT the global position estimate of the sytem, but rather a RAW sensor value. See 
%%~ message GLOBAL_POSITION for the global position estimate. Coordinate frame is 
%%~ right-handed, Z-axis up (GPS frame)
function S = parse_GPS_RAW_v0_9(S,p)
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
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

