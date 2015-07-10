%%  case: 1
%%~ The boot message indicates that a system is starting. The onboard software version 
%%~ allows to keep track of onboard soft/firmware revisions.
function p = encode_BOOT_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(4);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(1);
	name = [ ...
		{'version'}	 ... %% The onboard software version
		];
	byte = [ 4 ];
	type = [ {'uint32'} ];

	p = [head len pnum sysid id messid];
	%% Encode version data field
	val = typecast(S.version,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
