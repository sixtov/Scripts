%%  case: 169
%%~ Data packet, size 16
function p = encode_DATA16_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(18);
	sysid = uint8(S.sysid);
	id = uint8(S.id);
	messid = uint8(169);
	name = [ ...
		{'type'} ... %% data type
		{'len'}	 ... %% data length
		{'data'} ... %% raw data
		];
	byte = [ 1 1 16 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode type data field
	val = typecast(S.type,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode len data field
	val = typecast(S.len,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode data data field
	val = typecast(S.data,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
