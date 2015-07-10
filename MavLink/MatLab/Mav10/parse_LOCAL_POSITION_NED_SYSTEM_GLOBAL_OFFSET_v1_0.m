%%  case: 89
%%~ The offset in X, Y, Z and yaw between the LOCAL_POSITION_NED messages of MAV X and 
%%~ the global coordinate frame in NED coordinates. Coordinate frame is right-handed, 
%%~ Z-axis down (aeronautical frame, NED / north-east-down convention)
function S = parse_LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET_v1_0(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'x'}			 ... %% X Position
		{'y'}			 ... %% Y Position
		{'z'}			 ... %% Z Position
		{'roll'}		 ... %% Roll
		{'pitch'}		 ... %% Pitch
		{'yaw'}			 ... %% Yaw
		];
	byte = [ 4 4 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

