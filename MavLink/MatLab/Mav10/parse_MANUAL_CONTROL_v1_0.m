%%  case: 69
%%~ This message provides an API for manually controlling the vehicle using standard 
%%~ joystick axes nomenclature, along with a joystick-like input device. Unused axes 
%%~ can be disabled an buttons are also transmit as boolean values of their 
function S = parse_MANUAL_CONTROL_v1_0(p)
	name = [ ...
		{'target'}	 ... %% The system to be controlled.
		{'x'}		 ... %% X-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to forward(1000)-backward(-1000) movement on a joystick and the pitch of a vehicle.
		{'y'}		 ... %% Y-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to left(-1000)-right(1000) movement on a joystick and the roll of a vehicle.
		{'z'}		 ... %% Z-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a separate slider movement with maximum being 1000 and minimum being -1000 on a joystick and the thrust of a vehicle.
		{'r'}		 ... %% R-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a twisting of the joystick, with counter-clockwise being 1000 and clockwise being -1000, and the yaw of a vehicle.
		{'buttons'}	 ... %% A bitfield corresponding to the joystick buttons' current state, 1 for pressed, 0 for released. The lowest bit corresponds to Button 1.
		];
	byte = [ 1 2 2 2 2 2 ];
	type = [ {'uint8'} {'int16'} {'int16'} {'int16'} {'int16'} {'uint16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

