%%  case: 63
%%~ Setpoint for up to four quadrotors in a group / wing
function p = encode_SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST(S)
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

	%% Encode group data field
	val = typecast(S.group,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mode data field
	val = typecast(S.mode,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode led_red data field
	val = typecast(S.led_red,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode led_blue data field
	val = typecast(S.led_blue,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode led_green data field
	val = typecast(S.led_green,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode roll data field
	val = typecast(S.roll,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pitch data field
	val = typecast(S.pitch,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yaw data field
	val = typecast(S.yaw,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode thrust data field
	val = typecast(S.thrust,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
