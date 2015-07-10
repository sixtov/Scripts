%%  case: 250
function S = parse_DEBUG_VECT_v1_0(S,p)
	name = [ ...
		{'name'}		 ... %% Name
		{'time_usec'}	 ... %% Timestamp
		{'x'}			 ... %% x
		{'y'}			 ... %% y
		{'z'}			 ... %% z
		];
	byte = [ 10 8 4 4 4 ];
	type = [ {'uint8'} {'uint64'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

