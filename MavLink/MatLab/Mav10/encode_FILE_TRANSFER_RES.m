%%  case: 112
%%~ File transfer result
function p = encode_FILE_TRANSFER_RES(S)
	name = [ ...
		{'transfer_uid'} ... %% Unique transfer ID
		{'result'}		 ... %% 0: OK, 1: not permitted, 2: bad path / file name, 3: no space left on device
		];
	byte = [ 8 1 ];
	type = [ {'uint64'} {'uint8'} ];

	%% Encode transfer_uid data field
	val = typecast(S.transfer_uid,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode result data field
	val = typecast(S.result,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
