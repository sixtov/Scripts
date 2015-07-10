%%  case: 101
function S = parse_GLOBAL_VISION_POSITION_ESTIMATE_v1_0(p)
	name = [ ...
		{'usec'}	 ... %% Timestamp (microseconds, synced to UNIX time or since system boot)
		{'x'}		 ... %% Global X position
		{'y'}		 ... %% Global Y position
		{'z'}		 ... %% Global Z position
		{'roll'}	 ... %% Roll angle in rad
		{'pitch'}	 ... %% Pitch angle in rad
		{'yaw'}		 ... %% Yaw angle in rad
		];
	byte = [ 8 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

