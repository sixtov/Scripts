%%  case: 158
%%~ Message with some status from APM to GCS about camera or antenna mount
function p = encode_MOUNT_STATUS_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(14);
	sysid = uint8(S.sysid);
	id = uint8(S.id);
	messid = uint8(158);
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'pointing_a'}		 ... %% pitch(deg*100) or lat, depending on mount mode
		{'pointing_b'}		 ... %% roll(deg*100) or lon depending on mount mode
		{'pointing_c'}		 ... %% yaw(deg*100) or alt (in cm) depending on mount mode
		];
	byte = [ 1 1 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'int32'} {'int32'} {'int32'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pointing_a data field
	val = typecast(S.pointing_a,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pointing_b data field
	val = typecast(S.pointing_b,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pointing_c data field
	val = typecast(S.pointing_c,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
