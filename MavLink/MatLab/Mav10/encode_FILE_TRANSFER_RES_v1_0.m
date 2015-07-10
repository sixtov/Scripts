%%  case: 112
%%~ File transfer result
function p = encode_FILE_TRANSFER_RES_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(9);
	sysid = uint8(S.sysid);
	id = uint8(S.id);
	messid = uint8(112);
	name = [ ...
		{'transfer_uid'} ... %% Unique transfer ID
		{'result'}		 ... %% 0: OK, 1: not permitted, 2: bad path / file name, 3: no space left on device
		];
	byte = [ 8 1 ];
	type = [ {'uint64'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode transfer_uid data field
	val = typecast(S.transfer_uid,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode result data field
	val = typecast(S.result,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
