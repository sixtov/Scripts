%%  case: 62
%%~ Outputs of the APM navigation controller. The primary use of this message is to 
%%~ check the response and signs of the controller before actual flight and to assist 
%%~ with tuning controller parameters.
function S = parse_NAV_CONTROLLER_OUTPUT(S,p)
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
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

