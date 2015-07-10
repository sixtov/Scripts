%%  case: 160
%%~ Message sent to the MAV to set a new offset from the currently controlled position
function S = parse_SET_POSITION_CONTROL_OFFSET_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'x'}				 ... %% x position offset
		{'y'}				 ... %% y position offset
		{'z'}				 ... %% z position offset
		{'yaw'}				 ... %% yaw orientation offset in radians, 0 = NORTH
		];
	byte = [ 1 1 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

