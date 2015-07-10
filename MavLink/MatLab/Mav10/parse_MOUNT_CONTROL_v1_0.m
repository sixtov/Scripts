%%  case: 157
%%~ Message to control a camera mount, directional antenna, etc.
function S = parse_MOUNT_CONTROL_v1_0(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'input_a'}			 ... %% pitch(deg*100) or lat, depending on mount mode
		{'input_b'}			 ... %% roll(deg*100) or lon depending on mount mode
		{'input_c'}			 ... %% yaw(deg*100) or alt (in cm) depending on mount mode
		{'save_position'}	 ... %% if "1" it will save current trimmed position on EEPROM (just valid for NEUTRAL and LANDING)
		];
	byte = [ 1 1 4 4 4 1 ];
	type = [ {'uint8'} {'uint8'} {'int32'} {'int32'} {'int32'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

