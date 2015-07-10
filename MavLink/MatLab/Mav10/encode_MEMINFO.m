%%  case: 152
%%~ state of APM memory
function p = encode_MEMINFO(S)
	name = [ ...
		{'brkval'}	 ... %% heap top
		{'freemem'}	 ... %% free memory
		];
	byte = [ 2 2 ];
	type = [ {'uint16'} {'uint16'} ];

	%% Encode brkval data field
	val = typecast(S.brkval,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode freemem data field
	val = typecast(S.freemem,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
