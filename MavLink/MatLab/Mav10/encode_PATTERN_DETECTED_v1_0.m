%%  case: 190
function p = encode_PATTERN_DETECTED_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(106);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(190);
	name = [ ...
		{'type'}		 ... %% 0: Pattern, 1: Letter
		{'confidence'}	 ... %% Confidence of detection
		{'file'}		 ... %% Pattern file name
		{'detected'}	 ... %% Accepted as true detection, 0 no, 1 yes
		];
	byte = [ 1 4 100 1 ];
	type = [ {'uint8'} {'single'} {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode type data field
	val = typecast(S.type,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode confidence data field
	val = typecast(S.confidence,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode file data field
	val = typecast(S.file,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode detected data field
	val = typecast(S.detected,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
