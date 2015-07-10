%%%%  case: 10
%%~ An action message allows to execute a certain onboard action. These include liftoff, 
%%~ land, storing parameters too EEPROM, shutddown, etc. The action ids are defined 
%%~ in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
function p = encodeValues_ACTION_v0_9(target,target_component,action)
	S.target = typecast(uint8(target),'uint8');		% The system executing the action
	S.target_component = typecast(uint8(target_component),'uint8');		% The component executing the action
	S.action = typecast(uint8(action),'uint8');		% The action id
	p = encode_ACTION_v0_9(S);
return
