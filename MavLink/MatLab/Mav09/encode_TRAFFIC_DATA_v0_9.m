%%  case: 114
%%~ Message that provides 6 dof position data about other traffic. This includes: Vehicle 
%%~ number, latitud (deg), longitud (deg), altitud(meters), roll (deg), pitch 
%%~ (deg), heading(deg)
function p = encode_TRAFFIC_DATA_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(33);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(114);
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

	p = [head len pnum sysid id messid];
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

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
