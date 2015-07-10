%%  case: 10
%%~ An action message allows to execute a certain onboard action. These include liftoff, 
%%~ land, storing parameters too EEPROM, shutddown, etc. The action ids are defined 
%%~ in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
function S = parse_ACTION_v0_9(p)
	name = [ ...
		{'target'}			 ... %% The system executing the action
		{'target_component'} ... %% The component executing the action
		{'action'}			 ... %% The action id
		];
	byte = [ 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

