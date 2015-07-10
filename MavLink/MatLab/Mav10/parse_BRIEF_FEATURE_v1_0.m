%%  case: 195
function S = parse_BRIEF_FEATURE_v1_0(p)
	name = [ ...
		{'x'}						 ... %% x position in m
		{'y'}						 ... %% y position in m
		{'z'}						 ... %% z position in m
		{'orientation_assignment'}	 ... %% Orientation assignment 0: false, 1:true
		{'size'}					 ... %% Size in pixels
		{'orientation'}				 ... %% Orientation
		{'descriptor'}				 ... %% Descriptor
		{'response'}				 ... %% Harris operator response at this location
		];
	byte = [ 4 4 4 1 2 2 32 4 ];
	type = [ {'single'} {'single'} {'single'} {'uint8'} {'uint16'} {'uint16'} {'uint8'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

