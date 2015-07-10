%%  case: 114
%%~ Message that provides 6 dof position data about other traffic. This includes: Vehicle 
%%~ number, latitud (deg), longitud (deg), altitud(meters), roll (deg), pitch 
%%~ (deg), heading(deg)
function p = encode_TRAFFIC_DATA_v0_9(S)
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

	p = [];
	%% Encode ID data field
	val = typecast(S.ID,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lat data field
	val = typecast(S.lat,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lon data field
	val = typecast(S.lon,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode alt data field
	val = typecast(S.alt,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode roll data field
	val = typecast(S.roll,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pitch data field
	val = typecast(S.pitch,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode heading data field
	val = typecast(S.heading,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ownship_flag data field
	val = typecast(S.ownship_flag,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
