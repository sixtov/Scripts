%%  case: 252
%%~ Send a key-value pair as integer. The use of this message is discouraged for normal 
%%~ packets, but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function S = parse_NAMED_VALUE_INT_v1_0(p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'name'}		 ... %% Name of the debug variable
		{'value'}		 ... %% Signed integer value
		];
	byte = [ 4 10 4 ];
	type = [ {'uint32'} {'uint8'} {'int32'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

