%%  case: 158
%%~ Message with some status from APM to GCS about camera or antenna mount
function p = encode_MOUNT_STATUS_v1_0(S)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'pointing_a'}		 ... %% pitch(deg*100) or lat, depending on mount mode
		{'pointing_b'}		 ... %% roll(deg*100) or lon depending on mount mode
		{'pointing_c'}		 ... %% yaw(deg*100) or alt (in cm) depending on mount mode
		];
	byte = [ 1 1 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'int32'} {'int32'} {'int32'} ];

	p = [];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pointing_a data field
	val = typecast(S.pointing_a,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pointing_b data field
	val = typecast(S.pointing_b,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pointing_c data field
	val = typecast(S.pointing_c,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
