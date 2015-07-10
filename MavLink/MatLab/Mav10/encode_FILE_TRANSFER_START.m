%%  case: 110
%%~ Begin file transfer
function p = encode_FILE_TRANSFER_START(S)
	name = [ ...
		{'transfer_uid'} ... %% Unique transfer ID
		{'dest_path'}	 ... %% Destination path
		{'direction'}	 ... %% Transfer direction: 0: from requester, 1: to requester
		{'file_size'}	 ... %% File size in bytes
		{'flags'}		 ... %% RESERVED
		];
	byte = [ 8 240 1 4 1 ];
	type = [ {'uint64'} {'uint8'} {'uint8'} {'uint32'} {'uint8'} ];

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

return
