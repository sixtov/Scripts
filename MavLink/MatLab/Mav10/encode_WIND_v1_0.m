%%  case: 168
%%~ Wind estimation
function p = encode_WIND_v1_0(S)
	name = [ ...
		{'direction'}	 ... %% wind direction that wind is coming from (degrees)
		{'speed'}		 ... %% wind speed in ground plane (m/s)
		{'speed_z'}		 ... %% vertical wind speed (m/s)
		];
	byte = [ 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} ];

	p = [];
	%% Encode direction data field
	val = typecast(S.direction,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode speed data field
	val = typecast(S.speed,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode speed_z data field
	val = typecast(S.speed_z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
