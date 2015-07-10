%%%%  case: 156
%%~ Message to configure a camera mount, directional antenna, etc.
function p = encodeValues_MOUNT_CONFIGURE_v0_9(target_system,target_component,mount_mode,stab_roll,stab_pitch,stab_yaw)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.mount_mode = typecast(uint8(mount_mode),'uint8');		% mount operating mode (see MAV_MOUNT_MODE enum)
	S.stab_roll = typecast(uint8(stab_roll),'uint8');		% (1 = yes, 0 = no)
	S.stab_pitch = typecast(uint8(stab_pitch),'uint8');		% (1 = yes, 0 = no)
	S.stab_yaw = typecast(uint8(stab_yaw),'uint8');		% (1 = yes, 0 = no)
	p = encode_MOUNT_CONFIGURE_v0_9(S);
return
