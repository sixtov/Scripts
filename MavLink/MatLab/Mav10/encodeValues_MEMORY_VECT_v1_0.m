%%%%  case: 249
%%~ Send raw controller memory. The use of this message is discouraged for normal packets, 
%%~ but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function p = encodeValues_MEMORY_VECT_v1_0(address,ver,type,value)
	S.address = typecast(uint16(address),'uint16');		% Starting address of the debug variables
	S.ver = typecast(uint8(ver),'uint8');		% Version code of the type variable. 0=unknown, type ignored and assumed int16_t. 1=as below
	S.type = typecast(uint8(type),'uint8');		% Type code of the memory variables. for ver = 1: 0=16 x int16_t, 1=16 x uint16_t, 2=16 x Q15, 3=16 x 1Q14
	S.value = typecast(int8(value),'int8');		% Memory contents at specified address
	p = encode_MEMORY_VECT_v1_0(S);
return
