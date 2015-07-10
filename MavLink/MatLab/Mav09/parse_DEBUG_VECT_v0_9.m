%%  case: 251
function S = parse_DEBUG_VECT_v0_9(p)
	name = [ ...
		{'name'} ... %% Name
		{'usec'} ... %% Timestamp
		{'x'}	 ... %% x
		{'y'}	 ... %% y
		{'z'}	 ... %% z
		];
	byte = [ 10 8 4 4 4 ];
	type = [ {'uint8'} {'uint64'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

