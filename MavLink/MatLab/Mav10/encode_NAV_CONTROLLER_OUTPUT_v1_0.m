%%  case: 62
%%~ Outputs of the APM navigation controller. The primary use of this message is to 
%%~ check the response and signs of the controller before actual flight and to assist 
%%~ with tuning controller parameters.
function p = encode_NAV_CONTROLLER_OUTPUT_v1_0(S)
	name = [ ...
		{'nav_roll'}		 ... %% Current desired roll in degrees
		{'nav_pitch'}		 ... %% Current desired pitch in degrees
		{'nav_bearing'}		 ... %% Current desired heading in degrees
		{'target_bearing'}	 ... %% Bearing to current MISSION/target in degrees
		{'wp_dist'}			 ... %% Distance to active MISSION in meters
		{'alt_error'}		 ... %% Current altitude error in meters
		{'aspd_error'}		 ... %% Current airspeed error in meters/second
		{'xtrack_error'}	 ... %% Current crosstrack error on x-y plane in meters
		{'nav_wptrad'}		 ... %% Navigation waypoint radius in meters
		];
	byte = [ 4 4 2 2 2 4 4 4 4 ];
	type = [ {'single'} {'single'} {'int16'} {'int16'} {'uint16'} {'single'} {'single'} {'single'} {'single'} ];

	p = [];
	%% Encode nav_roll data field
	val = typecast(S.nav_roll,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode nav_pitch data field
	val = typecast(S.nav_pitch,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode nav_bearing data field
	val = typecast(S.nav_bearing,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_bearing data field
	val = typecast(S.target_bearing,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode wp_dist data field
	val = typecast(S.wp_dist,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode alt_error data field
	val = typecast(S.alt_error,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode aspd_error data field
	val = typecast(S.aspd_error,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode xtrack_error data field
	val = typecast(S.xtrack_error,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode nav_wptrad data field
	val = typecast(S.nav_wptrad,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
