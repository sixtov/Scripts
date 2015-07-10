%%  case: 168
%%~ Wind estimation
function S = parse_WIND_v1_0(S,p)
	name = [ ...
		{'direction'}	 ... %% wind direction that wind is coming from (degrees)
		{'speed'}		 ... %% wind speed in ground plane (m/s)
		{'speed_z'}		 ... %% vertical wind speed (m/s)
		];
	byte = [ 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

