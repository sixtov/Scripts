%%  case: 253
%%~ Send a key-value pair as integer. The use of this message is discouraged for normal 
%%~ packets, but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function p = encode_NAMED_VALUE_INT(S)
	name = [ ...
		{'name'}	 ... %% Name of the debug variable
		{'value'}	 ... %% Signed integer value
		];
	byte = [ 10 4 ];
	type = [ {'uint8'} {'int32'} ];

	%% Encode name data field
	val = typecast(S.name,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode value data field
	val = typecast(S.value,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
