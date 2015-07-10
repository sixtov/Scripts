%%  case: 156
%%~ Message to configure a camera mount, directional antenna, etc.
function S = parse_MOUNT_CONFIGURE(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'mount_mode'}		 ... %% mount operating mode (see MAV_MOUNT_MODE enum)
		{'stab_roll'}		 ... %% (1 = yes, 0 = no)
		{'stab_pitch'}		 ... %% (1 = yes, 0 = no)
		{'stab_yaw'}		 ... %% (1 = yes, 0 = no)
		];
	byte = [ 1 1 1 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

