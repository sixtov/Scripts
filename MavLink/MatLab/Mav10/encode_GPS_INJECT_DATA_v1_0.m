%%  case: 123
%%~ data for injecting into the onboard GPS (used for DGPS)
function p = encode_GPS_INJECT_DATA_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(113);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(123);
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'len'}				 ... %% data length
		{'data'}			 ... %% raw data (110 is enough for 12 satellites of RTCMv2)
		];
	byte = [ 1 1 1 110 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode len data field
	val = typecast(S.len,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode data data field
	val = typecast(S.data,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
