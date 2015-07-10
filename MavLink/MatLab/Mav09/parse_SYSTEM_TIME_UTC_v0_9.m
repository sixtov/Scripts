%%  case: 4
%%~ UTC date and time from GPS module
function S = parse_SYSTEM_TIME_UTC_v0_9(p)
	name = [ ...
		{'utc_date'} ... %% GPS UTC date ddmmyy
		{'utc_time'} ... %% GPS UTC time hhmmss
		];
	byte = [ 4 4 ];
	type = [ {'uint32'} {'uint32'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

