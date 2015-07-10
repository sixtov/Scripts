%%  case: 168
%%~ Wind estimation
function S = parse_WIND_v1_0(p)
	name = [ ...
		{'direction'}	 ... %% wind direction that wind is coming from (degrees)
		{'speed'}		 ... %% wind speed in ground plane (m/s)
		{'speed_z'}		 ... %% vertical wind speed (m/s)
		];
	byte = [ 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

