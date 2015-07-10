%%  case: 64
%%~ Corrects the systems state by adding an error correction term to the position and 
%%~ velocity, and by rotating the attitude by a correction angle.
function S = parse_STATE_CORRECTION_v0_9(p)
	name = [ ...
		{'xErr'}	 ... %% x position error
		{'yErr'}	 ... %% y position error
		{'zErr'}	 ... %% z position error
		{'rollErr'}	 ... %% roll error (radians)
		{'pitchErr'} ... %% pitch error (radians)
		{'yawErr'}	 ... %% yaw error (radians)
		{'vxErr'}	 ... %% x velocity
		{'vyErr'}	 ... %% y velocity
		{'vzErr'}	 ... %% z velocity
		];
	byte = [ 4 4 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

