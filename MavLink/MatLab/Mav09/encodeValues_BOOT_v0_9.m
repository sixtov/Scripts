%%%%  case: 1
%%~ The boot message indicates that a system is starting. The onboard software version 
%%~ allows to keep track of onboard soft/firmware revisions.
function p = encodeValues_BOOT_v0_9(version)
	S.version = typecast(uint32(version),'uint32');		% The onboard software version
	p = encode_BOOT_v0_9(S);
return
