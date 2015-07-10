%%  case: 252
%%~ Send a key-value pair as integer. The use of this message is discouraged for normal 
%%~ packets, but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function p = encode_NAMED_VALUE_INT(S)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'name'}		 ... %% Name of the debug variable
		{'value'}		 ... %% Signed integer value
		];
	byte = [ 4 10 4 ];
	type = [ {'uint32'} {'uint8'} {'int32'} ];

	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode name data field
	val = typecast(S.name,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode value data field
	val = typecast(S.value,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
