%%  case: 1
%%~ The boot message indicates that a system is starting. The onboard software version 
%%~ allows to keep track of onboard soft/firmware revisions.
function p = encode_BOOT(S)
	name = [ ...
		{'version'}	 ... %% The onboard software version
		];
	byte = [ 4 ];
	type = [ {'uint32'} ];

	%% Encode version data field
	val = typecast(S.version,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
