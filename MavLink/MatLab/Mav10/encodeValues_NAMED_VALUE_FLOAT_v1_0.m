%%%%  case: 251
%%~ Send a key-value pair as float. The use of this message is discouraged for normal 
%%~ packets, but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function p = encodeValues_NAMED_VALUE_FLOAT_v1_0(time_boot_ms,name,value)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp (milliseconds since system boot)
	S.name = typecast(uint8(name),'uint8');		% Name of the debug variable
	S.value = typecast(single(value),'single');		% Floating point value
	p = encode_NAMED_VALUE_FLOAT_v1_0(S);
return
