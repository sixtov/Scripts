%%  case: 58
%%~ Setpoint in roll, pitch, yaw currently active on the system.
function p = encode_ROLL_PITCH_YAW_THRUST_SETPOINT_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(20);
	sysid = uint8(S.sysid);
	id = uint8(S.id);
	messid = uint8(58);
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp in milliseconds since system boot
		{'roll'}		 ... %% Desired roll angle in radians
		{'pitch'}		 ... %% Desired pitch angle in radians
		{'yaw'}			 ... %% Desired yaw angle in radians
		{'thrust'}		 ... %% Collective thrust, normalized to 0 .. 1
		];
	byte = [ 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} ];

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

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
