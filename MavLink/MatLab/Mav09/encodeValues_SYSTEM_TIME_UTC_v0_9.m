%%%%  case: 4
%%~ UTC date and time from GPS module
function p = encodeValues_SYSTEM_TIME_UTC_v0_9(utc_date,utc_time)
	S.utc_date = typecast(uint32(utc_date),'uint32');		% GPS UTC date ddmmyy
	S.utc_time = typecast(uint32(utc_time),'uint32');		% GPS UTC time hhmmss
	p = encode_SYSTEM_TIME_UTC_v0_9(S);
return
