%%  case: 164
%%~ Status of simulation environment, if used
function S = parse_SIMSTATE_v1_0(p)
	name = [ ...
		{'roll'}	 ... %% Roll angle (rad)
		{'pitch'}	 ... %% Pitch angle (rad)
		{'yaw'}		 ... %% Yaw angle (rad)
		{'xacc'}	 ... %% X acceleration m/s/s
		{'yacc'}	 ... %% Y acceleration m/s/s
		{'zacc'}	 ... %% Z acceleration m/s/s
		{'xgyro'}	 ... %% Angular speed around X axis rad/s
		{'ygyro'}	 ... %% Angular speed around Y axis rad/s
		{'zgyro'}	 ... %% Angular speed around Z axis rad/s
		{'lat'}		 ... %% Latitude in degrees * 1E7
		{'lng'}		 ... %% Longitude in degrees * 1E7
		];
	byte = [ 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'int32'} {'int32'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

