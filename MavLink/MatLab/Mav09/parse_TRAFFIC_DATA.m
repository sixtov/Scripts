%%  case: 114
%%~ Message that provides 6 dof position data about other traffic. This includes: Vehicle 
%%~ number, latitud (deg), longitud (deg), altitud(meters), roll (deg), pitch 
%%~ (deg), heading(deg)
function S = parse_TRAFFIC_DATA(S,p)
	name = [ ...
		{'ID'}			 ... %% vehicle ID
		{'lat'}			 ... %% latitude (deg)
		{'lon'}			 ... %% longitude (deg)
		{'alt'}			 ... %% altitude (meters)
		{'roll'}		 ... %% roll (deg)
		{'pitch'}		 ... %% pitch (deg)
		{'heading'}		 ... %% heading (deg)
		{'ownship_flag'} ... %% identifies whether the aircraft is ownship (1) or not (0)
		];
	byte = [ 8 4 4 4 4 4 4 1 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

