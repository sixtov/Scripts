%%  case: 252
%%~ Send a key-value pair as float. The use of this message is discouraged for normal 
%%~ packets, but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function p = encode_NAMED_VALUE_FLOAT(S)
	name = [ ...
		{'name'}	 ... %% Name of the debug variable
		{'value'}	 ... %% Floating point value
		];
	byte = [ 10 4 ];
	type = [ {'uint8'} {'single'} ];

	%% Encode name data field
	val = typecast(S.name,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode value data field
	val = typecast(S.value,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
