%%  case: 4
%%~ UTC date and time from GPS module
function p = encode_SYSTEM_TIME_UTC(S)
	name = [ ...
		{'utc_date'} ... %% GPS UTC date ddmmyy
		{'utc_time'} ... %% GPS UTC time hhmmss
		];
	byte = [ 4 4 ];
	type = [ {'uint32'} {'uint32'} ];

	%% Encode utc_date data field
	val = typecast(S.utc_date,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode utc_time data field
	val = typecast(S.utc_time,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
