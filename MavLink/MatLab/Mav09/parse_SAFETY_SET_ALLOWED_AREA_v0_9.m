%%  case: 53
%%~ Set a safety zone (volume), which is defined by two corners of a cube. This message 
%%~ can be used to tell the MAV which setpoints/waypoints to accept and which to 
%%~ reject. Safety areas are often enforced by national or competition regulations.
function S = parse_SAFETY_SET_ALLOWED_AREA_v0_9(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'frame'}			 ... %% Coordinate frame, as defined by MAV_FRAME enum in mavlink_types.h. Can be either global, GPS, right-handed with Z axis up or local, right handed, Z axis down.
		{'p1x'}				 ... %% x position 1 / Latitude 1
		{'p1y'}				 ... %% y position 1 / Longitude 1
		{'p1z'}				 ... %% z position 1 / Altitude 1
		{'p2x'}				 ... %% x position 2 / Latitude 2
		{'p2y'}				 ... %% y position 2 / Longitude 2
		{'p2z'}				 ... %% z position 2 / Altitude 2
		];
	byte = [ 1 1 1 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

