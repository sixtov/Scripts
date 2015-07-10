%%  case: 131
function p = encode_ENCAPSULATED_DATA_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(255);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(131);
	name = [ ...
		{'seqnr'}	 ... %% sequence number (starting with 0 on every transmission)
		{'data'}	 ... %% image data bytes
		];
	byte = [ 2 253 ];
	type = [ {'uint16'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode seqnr data field
	val = typecast(S.seqnr,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode data data field
	val = typecast(S.data,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
