%%%%  case: 6
%%~ Accept / deny control of this MAV
function p = encodeValues_CHANGE_OPERATOR_CONTROL_ACK_v0_9(gcs_system_id,control_request,ack)
	S.gcs_system_id = typecast(uint8(gcs_system_id),'uint8');		% ID of the GCS this message 
	S.control_request = typecast(uint8(control_request),'uint8');		% 0: request control of this MAV, 1: Release control of this MAV
	S.ack = typecast(uint8(ack),'uint8');		% 0: ACK, 1: NACK: Wrong passkey, 2: NACK: Unsupported passkey encryption method, 3: NACK: Already under control
	p = encode_CHANGE_OPERATOR_CONTROL_ACK_v0_9(S);
return
