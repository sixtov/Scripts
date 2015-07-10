%%  case: 4
%%~ UTC date and time from GPS module
function p = encode_SYSTEM_TIME_UTC_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(8);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(4);
	name = [ ...
		{'utc_date'} ... %% GPS UTC date ddmmyy
		{'utc_time'} ... %% GPS UTC time hhmmss
		];
	byte = [ 4 4 ];
	type = [ {'uint32'} {'uint32'} ];

	p = [head len pnum sysid id messid];
	%% Encode utc_date data field
	val = typecast(S.utc_date,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode utc_time data field
	val = typecast(S.utc_time,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
