%%  case: 249
%%~ Send raw controller memory. The use of this message is discouraged for normal packets, 
%%~ but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function S = parse_MEMORY_VECT_v1_0(S,p)
	name = [ ...
		{'address'}	 ... %% Starting address of the debug variables
		{'ver'}		 ... %% Version code of the type variable. 0=unknown, type ignored and assumed int16_t. 1=as below
		{'type'}	 ... %% Type code of the memory variables. for ver = 1: 0=16 x int16_t, 1=16 x uint16_t, 2=16 x Q15, 3=16 x 1Q14
		{'value'}	 ... %% Memory contents at specified address
		];
	byte = [ 2 1 1 32 ];
	type = [ {'uint16'} {'uint8'} {'uint8'} {'int8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

