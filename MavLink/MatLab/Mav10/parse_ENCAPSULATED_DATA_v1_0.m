%%  case: 131
function S = parse_ENCAPSULATED_DATA_v1_0(p)
	name = [ ...
		{'seqnr'}	 ... %% sequence number (starting with 0 on every transmission)
		{'data'}	 ... %% image data bytes
		];
	byte = [ 2 253 ];
	type = [ {'uint16'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

