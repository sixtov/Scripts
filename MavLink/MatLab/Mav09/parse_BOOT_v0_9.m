%%  case: 1
%%~ The boot message indicates that a system is starting. The onboard software version 
%%~ allows to keep track of onboard soft/firmware revisions.
function S = parse_BOOT_v0_9(S,p)
	name = [ ...
		{'version'}	 ... %% The onboard software version
		];
	byte = [ 4 ];
	type = [ {'uint32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

