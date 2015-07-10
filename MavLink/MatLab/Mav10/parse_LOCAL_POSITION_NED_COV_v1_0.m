%%  case: 64
%%~ The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
%%~ frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down 
%%~ convention)
function S = parse_LOCAL_POSITION_NED_COV_v1_0(p)
	name = [ ...
		{'time_boot_ms'}	 ... %% Timestamp (milliseconds since system boot)
		{'time_utc'}		 ... %% Timestamp (microseconds since UNIX epoch) in UTC. 0 for unknown. Commonly filled by the precision time source of a GPS receiver.
		{'estimator_type'}	 ... %% Class id of the estimator this estimate originated from.
		{'x'}				 ... %% X Position
		{'y'}				 ... %% Y Position
		{'z'}				 ... %% Z Position
		{'vx'}				 ... %% X Speed
		{'vy'}				 ... %% Y Speed
		{'vz'}				 ... %% Z Speed
		{'covariance'}		 ... %% Covariance matrix (first six entries are the first ROW, next six entries are the second row, etc.)
		];
	byte = [ 4 8 1 4 4 4 4 4 4 144 ];
	type = [ {'uint32'} {'uint64'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

