%%  case: 55
%%~ Read out the safety zone the MAV currently assumes.
function S = parse_SAFETY_ALLOWED_AREA(S,p)
	name = [ ...
		{'frame'}	 ... %% Coordinate frame, as defined by MAV_FRAME enum in mavlink_types.h. Can be either global, GPS, right-handed with Z axis up or local, right handed, Z axis down.
		{'p1x'}		 ... %% x position 1 / Latitude 1
		{'p1y'}		 ... %% y position 1 / Longitude 1
		{'p1z'}		 ... %% z position 1 / Altitude 1
		{'p2x'}		 ... %% x position 2 / Latitude 2
		{'p2y'}		 ... %% y position 2 / Longitude 2
		{'p2z'}		 ... %% z position 2 / Altitude 2
		];
	byte = [ 1 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

