%%  case: 170
%%~ Data packet, size 32
function p = encode_DATA32_v1_0(S)
	name = [ ...
		{'type'} ... %% data type
		{'len'}	 ... %% data length
		{'data'} ... %% raw data
		];
	byte = [ 1 1 32 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];

	p = [];
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

return
