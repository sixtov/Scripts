%%  case: 253
%%~ Send a key-value pair as integer. The use of this message is discouraged for normal 
%%~ packets, but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function p = encode_NAMED_VALUE_INT_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(14);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(253);
	name = [ ...
		{'name'}	 ... %% Name of the debug variable
		{'value'}	 ... %% Signed integer value
		];
	byte = [ 10 4 ];
	type = [ {'uint8'} {'int32'} ];

	p = [head len pnum sysid id messid];
	%% Encode name data field
	val = typecast(S.name,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode value data field
	val = typecast(S.value,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
