%%  case: 7
%%~ Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol 
%%~ has been kept simple, so transmitting the key requires an encrypted channel 
%%~ for true safety.
function S = parse_AUTH_KEY_v1_0(p)
	name = [ ...
		{'key'}	 ... %% key
		];
	byte = [ 32 ];
	type = [ {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

