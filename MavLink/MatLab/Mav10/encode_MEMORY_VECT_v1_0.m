%%  case: 249
%%~ Send raw controller memory. The use of this message is discouraged for normal packets, 
%%~ but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function p = encode_MEMORY_VECT_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(36);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(249);
	name = [ ...
		{'address'}	 ... %% Starting address of the debug variables
		{'ver'}		 ... %% Version code of the type variable. 0=unknown, type ignored and assumed int16_t. 1=as below
		{'type'}	 ... %% Type code of the memory variables. for ver = 1: 0=16 x int16_t, 1=16 x uint16_t, 2=16 x Q15, 3=16 x 1Q14
		{'value'}	 ... %% Memory contents at specified address
		];
	byte = [ 2 1 1 32 ];
	type = [ {'uint16'} {'uint8'} {'uint8'} {'int8'} ];

	p = [head len pnum sysid id messid];
	%% Encode address data field
	val = typecast(S.address,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ver data field
	val = typecast(S.ver,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode type data field
	val = typecast(S.type,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode value data field
	val = typecast(S.value,'int8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
