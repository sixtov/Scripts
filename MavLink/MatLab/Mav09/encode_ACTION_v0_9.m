%%  case: 10
%%~ An action message allows to execute a certain onboard action. These include liftoff, 
%%~ land, storing parameters too EEPROM, shutddown, etc. The action ids are defined 
%%~ in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
function p = encode_ACTION_v0_9(S)
	name = [ ...
		{'target'}			 ... %% The system executing the action
		{'target_component'} ... %% The component executing the action
		{'action'}			 ... %% The action id
		];
	byte = [ 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];

	p = [];
	%% Encode target data field
	val = typecast(S.target,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode action data field
	val = typecast(S.action,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
