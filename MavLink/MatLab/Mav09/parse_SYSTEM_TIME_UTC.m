%%  case: 4
%%~ UTC date and time from GPS module
function S = parse_SYSTEM_TIME_UTC(S,p)
	name = [ ...
		{'utc_date'} ... %% GPS UTC date ddmmyy
		{'utc_time'} ... %% GPS UTC time hhmmss
		];
	byte = [ 4 4 ];
	type = [ {'uint32'} {'uint32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

