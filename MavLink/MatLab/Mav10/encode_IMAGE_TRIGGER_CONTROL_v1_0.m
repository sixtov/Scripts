%%  case: 153
function p = encode_IMAGE_TRIGGER_CONTROL_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(1);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(153);
	name = [ ...
		{'enable'}	 ... %% 0 to disable, 1 to enable
		];
	byte = [ 1 ];
	type = [ {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode enable data field
	val = typecast(S.enable,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
