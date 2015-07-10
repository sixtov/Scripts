%%  case: 173
%%~ Rangefinder reporting
function p = encode_RANGEFINDER_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(8);
	sysid = uint8(S.sysid);
	id = uint8(S.id);
	messid = uint8(173);
	name = [ ...
		{'distance'} ... %% distance in meters
		{'voltage'}	 ... %% raw voltage if available, zero otherwise
		];
	byte = [ 4 4 ];
	type = [ {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode distance data field
	val = typecast(S.distance,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode voltage data field
	val = typecast(S.voltage,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
