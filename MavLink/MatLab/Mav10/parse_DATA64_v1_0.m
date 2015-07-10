%%  case: 171
%%~ Data packet, size 64
function S = parse_DATA64_v1_0(p)
	name = [ ...
		{'type'} ... %% data type
		{'len'}	 ... %% data length
		{'data'} ... %% raw data
		];
	byte = [ 1 1 64 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

