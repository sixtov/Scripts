%%  case: 6
%%~ Accept / deny control of this MAV
function p = encode_CHANGE_OPERATOR_CONTROL_ACK_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(3);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(6);
	name = [ ...
		{'gcs_system_id'}	 ... %% ID of the GCS this message 
		{'control_request'}	 ... %% 0: request control of this MAV, 1: Release control of this MAV
		{'ack'}				 ... %% 0: ACK, 1: NACK: Wrong passkey, 2: NACK: Unsupported passkey encryption method, 3: NACK: Already under control
		];
	byte = [ 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode gcs_system_id data field
	val = typecast(S.gcs_system_id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode control_request data field
	val = typecast(S.control_request,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ack data field
	val = typecast(S.ack,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
