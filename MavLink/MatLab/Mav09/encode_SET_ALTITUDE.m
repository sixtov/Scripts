%%  case: 65
function p = encode_SET_ALTITUDE(S)
	name = [ ...
		{'target'}	 ... %% The system setting the altitude
		{'mode'}	 ... %% The new altitude in meters
		];
	byte = [ 1 4 ];
	type = [ {'uint8'} {'uint32'} ];

	%% Encode target data field
	val = typecast(S.target,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mode data field
	val = typecast(S.mode,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
