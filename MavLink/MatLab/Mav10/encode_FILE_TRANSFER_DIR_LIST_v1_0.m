%%  case: 111
%%~ Get directory listing
function p = encode_FILE_TRANSFER_DIR_LIST_v1_0(S)
	name = [ ...
		{'transfer_uid'} ... %% Unique transfer ID
		{'dir_path'}	 ... %% Directory path to list
		{'flags'}		 ... %% RESERVED
		];
	byte = [ 8 240 1 ];
	type = [ {'uint64'} {'uint8'} {'uint8'} ];

	p = [];
	%% Encode transfer_uid data field
	val = typecast(S.transfer_uid,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode dir_path data field
	val = typecast(S.dir_path,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode flags data field
	val = typecast(S.flags,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
