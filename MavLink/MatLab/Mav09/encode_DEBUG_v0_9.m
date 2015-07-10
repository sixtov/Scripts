%%  case: 255
%%~ Send a debug value. The index is used to discriminate between values. These values 
%%~ show up in the plot of QGroundControl as DEBUG N.
function p = encode_DEBUG_v0_9(S)
	name = [ ...
		{'ind'}		 ... %% index of debug variable
		{'value'}	 ... %% DEBUG value
		];
	byte = [ 1 4 ];
	type = [ {'uint8'} {'single'} ];

	p = [];
	%% Encode ind data field
	val = typecast(S.ind,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode value data field
	val = typecast(S.value,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
