%%  case: 81
%%~ Setpoint in roll, pitch, yaw and thrust from the operator
function p = encode_MANUAL_SETPOINT_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(22);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(81);
	name = [ ...
		{'time_boot_ms'}			 ... %% Timestamp in milliseconds since system boot
		{'roll'}					 ... %% Desired roll rate in radians per second
		{'pitch'}					 ... %% Desired pitch rate in radians per second
		{'yaw'}						 ... %% Desired yaw rate in radians per second
		{'thrust'}					 ... %% Collective thrust, normalized to 0 .. 1
		{'mode_switch'}				 ... %% Flight mode switch position, 0.. 255
		{'manual_override_switch'}	 ... %% Override mode switch position, 0.. 255
		];
	byte = [ 4 4 4 4 4 1 1 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
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

	%% Encode mode_switch data field
	val = typecast(S.mode_switch,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode manual_override_switch data field
	val = typecast(S.manual_override_switch,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
