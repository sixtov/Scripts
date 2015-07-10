%%  case: 83
%%~ Set the vehicle attitude and body angular rates.
function p = encode_ATTITUDE_TARGET_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(37);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(83);
	name = [ ...
		{'time_boot_ms'}	 ... %% Timestamp in milliseconds since system boot
		{'type_mask'}		 ... %% Mappings: If any of these bits are set, the corresponding input should be ignored: bit 1: body roll rate, bit 2: body pitch rate, bit 3: body yaw rate. bit 4-bit 7: reserved, bit 8: attitude
		{'q'}				 ... %% Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0)
		{'body_roll_rate'}	 ... %% Body roll rate in radians per second
		{'body_pitch_rate'}	 ... %% Body roll rate in radians per second
		{'body_yaw_rate'}	 ... %% Body roll rate in radians per second
		{'thrust'}			 ... %% Collective thrust, normalized to 0 .. 1 (-1 .. 1 for vehicles capable of reverse trust)
		];
	byte = [ 4 1 16 4 4 4 4 ];
	type = [ {'uint32'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode type_mask data field
	val = typecast(S.type_mask,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode q data field
	val = typecast(S.q,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode body_roll_rate data field
	val = typecast(S.body_roll_rate,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode body_pitch_rate data field
	val = typecast(S.body_pitch_rate,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode body_yaw_rate data field
	val = typecast(S.body_yaw_rate,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode thrust data field
	val = typecast(S.thrust,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
