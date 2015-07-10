%%  case: 173
%%~ Rangefinder reporting
function S = parse_RANGEFINDER_v1_0(p)
	name = [ ...
		{'distance'} ... %% distance in meters
		{'voltage'}	 ... %% raw voltage if available, zero otherwise
		];
	byte = [ 4 4 ];
	type = [ {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

