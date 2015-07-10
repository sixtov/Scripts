%%  case: 11
%%~ Set the system mode, as defined by enum MAV_MODE in mavlink/include/mavlink_types.h. 
%%~ There is no target component id as the mode is by definition for the overall 
%%~ aircraft, not only for one component.
function p = encode_SET_MODE_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(2);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(11);
	name = [ ...
		{'target'}	 ... %% The system setting the mode
		{'mode'}	 ... %% The new mode
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode target data field
	val = typecast(S.target,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mode data field
	val = typecast(S.mode,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
