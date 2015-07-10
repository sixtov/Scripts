%%  case: 43
%%~ Request the overall list of mission items from the system/component.
function p = encode_MISSION_REQUEST_LIST_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(2);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(43);
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
