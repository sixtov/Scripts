%%  case: 31
%%~ The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), 
%%~ expressed as quaternion.
function p = encode_ATTITUDE_QUATERNION(S)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'q1'}			 ... %% Quaternion component 1
		{'q2'}			 ... %% Quaternion component 2
		{'q3'}			 ... %% Quaternion component 3
		{'q4'}			 ... %% Quaternion component 4
		{'rollspeed'}	 ... %% Roll angular speed (rad/s)
		{'pitchspeed'}	 ... %% Pitch angular speed (rad/s)
		{'yawspeed'}	 ... %% Yaw angular speed (rad/s)
		];
	byte = [ 4 4 4 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

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

return
