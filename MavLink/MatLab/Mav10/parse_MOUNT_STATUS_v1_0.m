%%  case: 158
%%~ Message with some status from APM to GCS about camera or antenna mount
function S = parse_MOUNT_STATUS_v1_0(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'pointing_a'}		 ... %% pitch(deg*100) or lat, depending on mount mode
		{'pointing_b'}		 ... %% roll(deg*100) or lon depending on mount mode
		{'pointing_c'}		 ... %% yaw(deg*100) or alt (in cm) depending on mount mode
		];
	byte = [ 1 1 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'int32'} {'int32'} {'int32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

