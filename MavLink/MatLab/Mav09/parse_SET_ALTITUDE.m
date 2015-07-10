%%  case: 65
function S = parse_SET_ALTITUDE(S,p)
	name = [ ...
		{'target'}	 ... %% The system setting the altitude
		{'mode'}	 ... %% The new altitude in meters
		];
	byte = [ 1 4 ];
	type = [ {'uint8'} {'uint32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

