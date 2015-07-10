%%  case: 63
%%~ The filtered global position (e.g. fused GPS and accelerometers). The position is 
%%~ in GPS-frame (right-handed, Z-up). It  is designed as scaled integer message since 
%%~ the resolution of float is not sufficient. NOTE: This message is intended for 
%%~ onboard networks / companion computers and higher-bandwidth links and optimized 
%%~ for accuracy and completeness. Please use the GLOBAL_POSITION_INT message for 
%%~ a minimal subset.
function S = parse_GLOBAL_POSITION_INT_COV_v1_0(p)
	name = [ ...
		{'time_boot_ms'}	 ... %% Timestamp (milliseconds since system boot)
		{'time_utc'}		 ... %% Timestamp (microseconds since UNIX epoch) in UTC. 0 for unknown. Commonly filled by the precision time source of a GPS receiver.
		{'estimator_type'}	 ... %% Class id of the estimator this estimate originated from.
		{'lat'}				 ... %% Latitude, expressed as degrees * 1E7
		{'lon'}				 ... %% Longitude, expressed as degrees * 1E7
		{'alt'}				 ... %% Altitude in meters, expressed as * 1000 (millimeters), above MSL
		{'relative_alt'}	 ... %% Altitude above ground in meters, expressed as * 1000 (millimeters)
		{'vx'}				 ... %% Ground X Speed (Latitude), expressed as m/s
		{'vy'}				 ... %% Ground Y Speed (Longitude), expressed as m/s
		{'vz'}				 ... %% Ground Z Speed (Altitude), expressed as m/s
		{'covariance'}		 ... %% Covariance matrix (first six entries are the first ROW, next six entries are the second row, etc.)
		];
	byte = [ 4 8 1 4 4 4 4 4 4 4 144 ];
	type = [ {'uint32'} {'uint64'} {'uint8'} {'int32'} {'int32'} {'int32'} {'int32'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

