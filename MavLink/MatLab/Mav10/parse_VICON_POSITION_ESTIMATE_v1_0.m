%%  case: 104
function S = parse_VICON_POSITION_ESTIMATE_v1_0(S,p)
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
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

