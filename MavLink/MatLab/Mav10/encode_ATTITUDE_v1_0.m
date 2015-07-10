%%  case: 30
%%~ The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right).
function p = encode_ATTITUDE_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(28);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(30);
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'roll'}		 ... %% Roll angle (rad, -pi..+pi)
		{'pitch'}		 ... %% Pitch angle (rad, -pi..+pi)
		{'yaw'}			 ... %% Yaw angle (rad, -pi..+pi)
		{'rollspeed'}	 ... %% Roll angular speed (rad/s)
		{'pitchspeed'}	 ... %% Pitch angular speed (rad/s)
		{'yawspeed'}	 ... %% Yaw angular speed (rad/s)
		];
	byte = [ 4 4 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

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

	%% Encode rollspeed data field
	val = typecast(S.rollspeed,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pitchspeed data field
	val = typecast(S.pitchspeed,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yawspeed data field
	val = typecast(S.yawspeed,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
