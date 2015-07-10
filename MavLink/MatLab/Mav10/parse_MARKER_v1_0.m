%%  case: 171
function S = parse_MARKER_v1_0(p)
	name = [ ...
		{'id'}		 ... %% ID
		{'x'}		 ... %% x position
		{'y'}		 ... %% y position
		{'z'}		 ... %% z position
		{'roll'}	 ... %% roll orientation
		{'pitch'}	 ... %% pitch orientation
		{'yaw'}		 ... %% yaw orientation
		];
	byte = [ 2 4 4 4 4 4 4 ];
	type = [ {'uint16'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

