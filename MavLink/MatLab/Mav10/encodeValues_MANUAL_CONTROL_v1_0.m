%%%%  case: 69
%%~ This message provides an API for manually controlling the vehicle using standard 
%%~ joystick axes nomenclature, along with a joystick-like input device. Unused axes 
%%~ can be disabled an buttons are also transmit as boolean values of their 
function p = encodeValues_MANUAL_CONTROL_v1_0(target,x,y,z,r,buttons)
	S.target = typecast(uint8(target),'uint8');		% The system to be controlled.
	S.x = typecast(int16(x),'int16');		% X-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to forward(1000)-backward(-1000) movement on a joystick and the pitch of a vehicle.
	S.y = typecast(int16(y),'int16');		% Y-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to left(-1000)-right(1000) movement on a joystick and the roll of a vehicle.
	S.z = typecast(int16(z),'int16');		% Z-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a separate slider movement with maximum being 1000 and minimum being -1000 on a joystick and the thrust of a vehicle.
	S.r = typecast(int16(r),'int16');		% R-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a twisting of the joystick, with counter-clockwise being 1000 and clockwise being -1000, and the yaw of a vehicle.
	S.buttons = typecast(uint16(buttons),'uint16');		% A bitfield corresponding to the joystick buttons' current state, 1 for pressed, 0 for released. The lowest bit corresponds to Button 1.
	p = encode_MANUAL_CONTROL_v1_0(S);
return
