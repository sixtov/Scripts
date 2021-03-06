%%  case: 110
%%~ Begin file transfer
function p = encode_FILE_TRANSFER_START_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(254);
	sysid = uint8(S.sysid);
	id = uint8(S.id);
	messid = uint8(110);
	name = [ ...
		{'transfer_uid'} ... %% Unique transfer ID
		{'dest_path'}	 ... %% Destination path
		{'direction'}	 ... %% Transfer direction: 0: from requester, 1: to requester
		{'file_size'}	 ... %% File size in bytes
		{'flags'}		 ... %% RESERVED
		];
	byte = [ 8 240 1 4 1 ];
	type = [ {'uint64'} {'uint8'} {'uint8'} {'uint32'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode transfer_uid data field
	val = typecast(S.transfer_uid,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode dest_path data field
	val = typecast(S.dest_path,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode direction data field
	val = typecast(S.direction,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode file_size data field
	val = typecast(S.file_size,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode flags data field
	val = typecast(S.flags,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
