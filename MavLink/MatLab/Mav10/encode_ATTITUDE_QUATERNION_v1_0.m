%%  case: 31
%%~ The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), 
%%~ expressed as quaternion. Quaternion order is w, x, y, z and a zero rotation would 
%%~ be expressed as (1 0 0 0).
function p = encode_ATTITUDE_QUATERNION_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(32);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(31);
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'q1'}			 ... %% Quaternion component 1, w (1 in null-rotation)
		{'q2'}			 ... %% Quaternion component 2, x (0 in null-rotation)
		{'q3'}			 ... %% Quaternion component 3, y (0 in null-rotation)
		{'q4'}			 ... %% Quaternion component 4, z (0 in null-rotation)
		{'rollspeed'}	 ... %% Roll angular speed (rad/s)
		{'pitchspeed'}	 ... %% Pitch angular speed (rad/s)
		{'yawspeed'}	 ... %% Yaw angular speed (rad/s)
		];
	byte = [ 4 4 4 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode q1 data field
	val = typecast(S.q1,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode q2 data field
	val = typecast(S.q2,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode q3 data field
	val = typecast(S.q3,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode q4 data field
	val = typecast(S.q4,'single');
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
