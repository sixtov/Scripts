%%  case: 173
%%~ Rangefinder reporting
function S = parse_RANGEFINDER(S,p)
	name = [ ...
		{'distance'} ... %% distance in meters
		{'voltage'}	 ... %% raw voltage if available, zero otherwise
		];
	byte = [ 4 4 ];
	type = [ {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

