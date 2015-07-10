%%  case: 171
%%~ Data packet, size 64
function S = parse_DATA64(S,p)
	name = [ ...
		{'type'} ... %% data type
		{'len'}	 ... %% data length
		{'data'} ... %% raw data
		];
	byte = [ 1 1 64 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

