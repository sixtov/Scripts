%%  case: 65
function S = parse_SET_ALTITUDE_v0_9(p)
	name = [ ...
		{'target'}	 ... %% The system setting the altitude
		{'mode'}	 ... %% The new altitude in meters
		];
	byte = [ 1 4 ];
	type = [ {'uint8'} {'uint32'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

