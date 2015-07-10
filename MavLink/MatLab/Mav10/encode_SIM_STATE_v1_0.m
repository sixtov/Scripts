%%  case: 108
%%~ Status of simulation environment, if used
function p = encode_SIM_STATE_v1_0(S)
	name = [ ...
		{'q1'}			 ... %% True attitude quaternion component 1
		{'q2'}			 ... %% True attitude quaternion component 2
		{'q3'}			 ... %% True attitude quaternion component 3
		{'q4'}			 ... %% True attitude quaternion component 4
		{'roll'}		 ... %% Attitude roll expressed as Euler angles, not recommended except for human-readable outputs
		{'pitch'}		 ... %% Attitude pitch expressed as Euler angles, not recommended except for human-readable outputs
		{'yaw'}			 ... %% Attitude yaw expressed as Euler angles, not recommended except for human-readable outputs
		{'xacc'}		 ... %% X acceleration m/s/s
		{'yacc'}		 ... %% Y acceleration m/s/s
		{'zacc'}		 ... %% Z acceleration m/s/s
		{'xgyro'}		 ... %% Angular speed around X axis rad/s
		{'ygyro'}		 ... %% Angular speed around Y axis rad/s
		{'zgyro'}		 ... %% Angular speed around Z axis rad/s
		{'lat'}			 ... %% Latitude in degrees
		{'lon'}			 ... %% Longitude in degrees
		{'alt'}			 ... %% Altitude in meters
		{'std_dev_horz'} ... %% Horizontal position standard deviation
		{'std_dev_vert'} ... %% Vertical position standard deviation
		{'vn'}			 ... %% True velocity in m/s in NORTH direction in earth-fixed NED frame
		{'ve'}			 ... %% True velocity in m/s in EAST direction in earth-fixed NED frame
		{'vd'}			 ... %% True velocity in m/s in DOWN direction in earth-fixed NED frame
		];
	byte = [ 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	p = [];
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

	%% Encode xacc data field
	val = typecast(S.xacc,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yacc data field
	val = typecast(S.yacc,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zacc data field
	val = typecast(S.zacc,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode xgyro data field
	val = typecast(S.xgyro,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ygyro data field
	val = typecast(S.ygyro,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zgyro data field
	val = typecast(S.zgyro,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lat data field
	val = typecast(S.lat,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lon data field
	val = typecast(S.lon,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode alt data field
	val = typecast(S.alt,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode std_dev_horz data field
	val = typecast(S.std_dev_horz,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode std_dev_vert data field
	val = typecast(S.std_dev_vert,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vn data field
	val = typecast(S.vn,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ve data field
	val = typecast(S.ve,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vd data field
	val = typecast(S.vd,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
