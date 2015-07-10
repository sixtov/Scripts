%%  case: 152
%%~ state of APM memory
function p = encode_MEMINFO_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(4);
	sysid = uint8(S.sysid);
	id = uint8(S.id);
	messid = uint8(152);
	name = [ ...
		{'brkval'}	 ... %% heap top
		{'freemem'}	 ... %% free memory
		];
	byte = [ 2 2 ];
	type = [ {'uint16'} {'uint16'} ];

	p = [head len pnum sysid id messid];
	%% Encode brkval data field
	val = typecast(S.brkval,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode freemem data field
	val = typecast(S.freemem,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
