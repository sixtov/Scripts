%%  case: 56
%%~ Set roll, pitch and yaw.
function p = encode_SET_ROLL_PITCH_YAW_THRUST_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(18);
	sysid = uint8(S.sysid);
	id = uint8(S.id);
	messid = uint8(56);
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'roll'}			 ... %% Desired roll angle in radians
		{'pitch'}			 ... %% Desired pitch angle in radians
		{'yaw'}				 ... %% Desired yaw angle in radians
		{'thrust'}			 ... %% Collective thrust, normalized to 0 .. 1
		];
	byte = [ 1 1 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode roll data field
	val = typecast(S.roll,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pitch data field
	val = typecast(S.pitch,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yaw data field
	val = typecast(S.yaw,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode thrust data field
	val = typecast(S.thrust,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
