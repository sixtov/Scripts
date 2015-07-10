%%  case: 63
%%~ Setpoint for up to four quadrotors in a group / wing
function S = parse_SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST(S,p)
	name = [ ...
		{'group'}		 ... %% ID of the quadrotor group (0 - 255, up to 256 groups supported)
		{'mode'}		 ... %% ID of the flight mode (0 - 255, up to 256 modes supported)
		{'led_red'}		 ... %% RGB red channel (0-255)
		{'led_blue'}	 ... %% RGB green channel (0-255)
		{'led_green'}	 ... %% RGB blue channel (0-255)
		{'roll'}		 ... %% Desired roll angle in radians +-PI (+-INT16_MAX)
		{'pitch'}		 ... %% Desired pitch angle in radians +-PI (+-INT16_MAX)
		{'yaw'}			 ... %% Desired yaw angle in radians, scaled to int16 +-PI (+-INT16_MAX)
		{'thrust'}		 ... %% Collective thrust, scaled to uint16 (0..UINT16_MAX)
		];
	byte = [ 1 1 4 4 4 8 8 8 8 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'int16'} {'int16'} {'int16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

