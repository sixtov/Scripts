%%  case: 6
%%~ Accept / deny control of this MAV
function S = parse_CHANGE_OPERATOR_CONTROL_ACK_v1_0(p)
	name = [ ...
		{'gcs_system_id'}	 ... %% ID of the GCS this message 
		{'control_request'}	 ... %% 0: request control of this MAV, 1: Release control of this MAV
		{'ack'}				 ... %% 0: ACK, 1: NACK: Wrong passkey, 2: NACK: Unsupported passkey encryption method, 3: NACK: Already under control
		];
	byte = [ 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

