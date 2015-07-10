%%%%  case: 157
%%~ Message to control a camera mount, directional antenna, etc.
function p = encodeValues_MOUNT_CONTROL_v0_9(target_system,target_component,input_a,input_b,input_c,save_position)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.input_a = typecast(int32(input_a),'int32');		% pitch(deg*100) or lat, depending on mount mode
	S.input_b = typecast(int32(input_b),'int32');		% roll(deg*100) or lon depending on mount mode
	S.input_c = typecast(int32(input_c),'int32');		% yaw(deg*100) or alt (in cm) depending on mount mode
	S.save_position = typecast(uint8(save_position),'uint8');		% if "1" it will save current trimmed position on EEPROM (just valid for NEUTRAL and LANDING)
	p = encode_MOUNT_CONTROL_v0_9(S);
return
