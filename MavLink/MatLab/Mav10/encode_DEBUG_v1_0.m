%%  case: 254
%%~ Send a debug value. The index is used to discriminate between values. These values 
%%~ show up in the plot of QGroundControl as DEBUG N.
function p = encode_DEBUG_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(9);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(254);
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'ind'}			 ... %% index of debug variable
		{'value'}		 ... %% DEBUG value
		];
	byte = [ 4 1 4 ];
	type = [ {'uint32'} {'uint8'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ind data field
	val = typecast(S.ind,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode value data field
	val = typecast(S.value,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
