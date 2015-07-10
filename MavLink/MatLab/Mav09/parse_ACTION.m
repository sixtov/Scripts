%%  case: 10
%%~ An action message allows to execute a certain onboard action. These include liftoff, 
%%~ land, storing parameters too EEPROM, shutddown, etc. The action ids are defined 
%%~ in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
function S = parse_ACTION(S,p)
	name = [ ...
		{'target'}			 ... %% The system executing the action
		{'target_component'} ... %% The component executing the action
		{'action'}			 ... %% The action id
		];
	byte = [ 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

