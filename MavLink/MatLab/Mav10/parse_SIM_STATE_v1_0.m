%%  case: 108
%%~ Status of simulation environment, if used
function S = parse_SIM_STATE_v1_0(p)
	name = [ ...
		{'q1'}			 ... %% True attitude quaternion component 1, w (1 in null-rotation)
		{'q2'}			 ... %% True attitude quaternion component 2, x (0 in null-rotation)
		{'q3'}			 ... %% True attitude quaternion component 3, y (0 in null-rotation)
		{'q4'}			 ... %% True attitude quaternion component 4, z (0 in null-rotation)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

