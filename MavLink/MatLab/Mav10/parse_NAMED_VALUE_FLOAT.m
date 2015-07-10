%%  case: 251
%%~ Send a key-value pair as float. The use of this message is discouraged for normal 
%%~ packets, but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function S = parse_NAMED_VALUE_FLOAT(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'name'}		 ... %% Name of the debug variable
		{'value'}		 ... %% Floating point value
		];
	byte = [ 4 10 4 ];
	type = [ {'uint32'} {'uint8'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

