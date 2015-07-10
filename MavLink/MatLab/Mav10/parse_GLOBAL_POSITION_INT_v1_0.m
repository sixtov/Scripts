%%  case: 33
%%~ The filtered global position (e.g. fused GPS and accelerometers). The position is 
%%~ in GPS-frame (right-handed, Z-up). It                is designed as scaled integer 
%%~ message since the resolution of float is not sufficient.
function S = parse_GLOBAL_POSITION_INT_v1_0(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

