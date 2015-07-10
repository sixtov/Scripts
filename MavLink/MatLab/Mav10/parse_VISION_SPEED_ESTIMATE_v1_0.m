%%  case: 103
function S = parse_VISION_SPEED_ESTIMATE_v1_0(p)
	name = [ ...
		{'usec'} ... %% Timestamp (microseconds, synced to UNIX time or since system boot)
		{'x'}	 ... %% Global X speed
		{'y'}	 ... %% Global Y speed
		{'z'}	 ... %% Global Z speed
		];
	byte = [ 8 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

