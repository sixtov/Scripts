%%%%  case: 158
%%~ Message with some status from APM to GCS about camera or antenna mount
function p = encodeValues_MOUNT_STATUS_v1_0(target_system,target_component,pointing_a,pointing_b,pointing_c)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.pointing_a = typecast(int32(pointing_a),'int32');		% pitch(deg*100) or lat, depending on mount mode
	S.pointing_b = typecast(int32(pointing_b),'int32');		% roll(deg*100) or lon depending on mount mode
	S.pointing_c = typecast(int32(pointing_c),'int32');		% yaw(deg*100) or alt (in cm) depending on mount mode
	p = encode_MOUNT_STATUS_v1_0(S);
return
