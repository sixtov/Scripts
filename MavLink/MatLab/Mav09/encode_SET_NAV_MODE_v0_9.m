%%  case: 12
%%~ Set the system navigation mode, as defined by enum MAV_NAV_MODE in mavlink/include/mavlink_types.h. 
%%~ The navigation mode applies to the whole aircraft and thus all 
%%~ components.
function p = encode_SET_NAV_MODE_v0_9(S)
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
	messid = uint8(12);
	name = [ ...
		{'target'}	 ... %% The system setting the mode
		{'nav_mode'} ... %% The new navigation mode
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode target data field
	val = typecast(S.target,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode nav_mode data field
	val = typecast(S.nav_mode,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
