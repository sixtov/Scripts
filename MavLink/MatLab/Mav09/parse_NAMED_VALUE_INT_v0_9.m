%%  case: 253
%%~ Send a key-value pair as integer. The use of this message is discouraged for normal 
%%~ packets, but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function S = parse_NAMED_VALUE_INT_v0_9(S,p)
	name = [ ...
		{'name'}	 ... %% Name of the debug variable
		{'value'}	 ... %% Signed integer value
		];
	byte = [ 10 4 ];
	type = [ {'uint8'} {'int32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

