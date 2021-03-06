%%  case: 65
function p = encode_SET_ALTITUDE_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(5);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(65);
	name = [ ...
		{'target'}	 ... %% The system setting the altitude
		{'mode'}	 ... %% The new altitude in meters
		];
	byte = [ 1 4 ];
	type = [ {'uint8'} {'uint32'} ];

	p = [head len pnum sysid id messid];
	%% Encode target data field
	val = typecast(S.target,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mode data field
	val = typecast(S.mode,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
