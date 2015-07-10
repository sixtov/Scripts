%%  case: 168
%%~ Wind estimation
function p = encode_WIND_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(12);
	sysid = uint8(S.sysid);
	id = uint8(S.id);
	messid = uint8(168);
	name = [ ...
		{'direction'}	 ... %% wind direction that wind is coming from (degrees)
		{'speed'}		 ... %% wind speed in ground plane (m/s)
		{'speed_z'}		 ... %% vertical wind speed (m/s)
		];
	byte = [ 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
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

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
