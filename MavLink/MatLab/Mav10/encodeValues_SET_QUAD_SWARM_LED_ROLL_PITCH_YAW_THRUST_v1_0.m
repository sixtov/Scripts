%%%%  case: 63
%%~ Setpoint for up to four quadrotors in a group / wing
function p = encodeValues_SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST_v1_0(group,mode,led_red,led_blue,led_green,roll,pitch,yaw,thrust)
	S.group = typecast(uint8(group),'uint8');		% ID of the quadrotor group (0 - 255, up to 256 groups supported)
	S.mode = typecast(uint8(mode),'uint8');		% ID of the flight mode (0 - 255, up to 256 modes supported)
	S.led_red = typecast(uint8(led_red),'uint8');		% RGB red channel (0-255)
	S.led_blue = typecast(uint8(led_blue),'uint8');		% RGB green channel (0-255)
	S.led_green = typecast(uint8(led_green),'uint8');		% RGB blue channel (0-255)
	S.roll = typecast(int16(roll),'int16');		% Desired roll angle in radians +-PI (+-INT16_MAX)
	S.pitch = typecast(int16(pitch),'int16');		% Desired pitch angle in radians +-PI (+-INT16_MAX)
	S.yaw = typecast(int16(yaw),'int16');		% Desired yaw angle in radians, scaled to int16 +-PI (+-INT16_MAX)
	S.thrust = typecast(uint16(thrust),'uint16');		% Collective thrust, scaled to uint16 (0..UINT16_MAX)
	p = encode_SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST_v1_0(S);
return
