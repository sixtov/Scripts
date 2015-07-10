%%  case: 173
%%~ Rangefinder reporting
function p = encode_RANGEFINDER_v1_0(S)
	name = [ ...
		{'distance'} ... %% distance in meters
		{'voltage'}	 ... %% raw voltage if available, zero otherwise
		];
	byte = [ 4 4 ];
	type = [ {'single'} {'single'} ];

	p = [];
	%% Encode distance data field
	val = typecast(S.distance,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode voltage data field
	val = typecast(S.voltage,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
