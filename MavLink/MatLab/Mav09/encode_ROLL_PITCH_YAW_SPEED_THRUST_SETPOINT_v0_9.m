%%  case: 58
%%~ Setpoint in rollspeed, pitchspeed, yawspeed currently active on the system.
function p = encode_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(24);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(58);
	name = [ ...
		{'time_us'}		 ... %% Timestamp in micro seconds since unix epoch
		{'roll_speed'}	 ... %% Desired roll angular speed in rad/s
		{'pitch_speed'}	 ... %% Desired pitch angular speed in rad/s
		{'yaw_speed'}	 ... %% Desired yaw angular speed in rad/s
		{'thrust'}		 ... %% Collective thrust, normalized to 0 .. 1
		];
	byte = [ 8 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_us data field
	val = typecast(S.time_us,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode roll_speed data field
	val = typecast(S.roll_speed,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pitch_speed data field
	val = typecast(S.pitch_speed,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yaw_speed data field
	val = typecast(S.yaw_speed,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode thrust data field
	val = typecast(S.thrust,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
