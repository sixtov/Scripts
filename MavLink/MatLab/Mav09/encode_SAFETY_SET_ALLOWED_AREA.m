%%  case: 53
%%~ Set a safety zone (volume), which is defined by two corners of a cube. This message 
%%~ can be used to tell the MAV which setpoints/waypoints to accept and which to 
%%~ reject. Safety areas are often enforced by national or competition regulations.
function p = encode_SAFETY_SET_ALLOWED_AREA(S)
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

	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode frame data field
	val = typecast(S.frame,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode p1x data field
	val = typecast(S.p1x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode p1y data field
	val = typecast(S.p1y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode p1z data field
	val = typecast(S.p1z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode p2x data field
	val = typecast(S.p2x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode p2y data field
	val = typecast(S.p2y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode p2z data field
	val = typecast(S.p2z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
