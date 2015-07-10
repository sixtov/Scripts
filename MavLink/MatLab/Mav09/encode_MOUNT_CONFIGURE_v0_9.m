%%  case: 156
%%~ Message to configure a camera mount, directional antenna, etc.
function p = encode_MOUNT_CONFIGURE_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(6);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(156);
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'mount_mode'}		 ... %% mount operating mode (see MAV_MOUNT_MODE enum)
		{'stab_roll'}		 ... %% (1 = yes, 0 = no)
		{'stab_pitch'}		 ... %% (1 = yes, 0 = no)
		{'stab_yaw'}		 ... %% (1 = yes, 0 = no)
		];
	byte = [ 1 1 1 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mount_mode data field
	val = typecast(S.mount_mode,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode stab_roll data field
	val = typecast(S.stab_roll,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode stab_pitch data field
	val = typecast(S.stab_pitch,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode stab_yaw data field
	val = typecast(S.stab_yaw,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
