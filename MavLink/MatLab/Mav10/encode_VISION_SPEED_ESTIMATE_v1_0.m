%%  case: 103
function p = encode_VISION_SPEED_ESTIMATE_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(20);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(103);
	name = [ ...
		{'usec'} ... %% Timestamp (microseconds, synced to UNIX time or since system boot)
		{'x'}	 ... %% Global X speed
		{'y'}	 ... %% Global Y speed
		{'z'}	 ... %% Global Z speed
		];
	byte = [ 8 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode usec data field
	val = typecast(S.usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode x data field
	val = typecast(S.x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode y data field
	val = typecast(S.y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode z data field
	val = typecast(S.z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
