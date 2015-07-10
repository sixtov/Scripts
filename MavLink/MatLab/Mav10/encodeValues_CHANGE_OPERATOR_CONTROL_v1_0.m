%%%%  case: 5
%%~ Request to control this MAV
function p = encodeValues_CHANGE_OPERATOR_CONTROL_v1_0(target_system,control_request,version,passkey)
	S.target_system = typecast(uint8(target_system),'uint8');		% System the GCS requests control for
	S.control_request = typecast(uint8(control_request),'uint8');		% 0: request control of this MAV, 1: Release control of this MAV
	S.version = typecast(uint8(version),'uint8');		% 0: key as plaintext, 1-255: future, different hashing/encryption variants. The GCS should in general use the safest mode possible initially and then gradually move down the encryption level if it gets a NACK message indicating an encryption mismatch.
	S.passkey = typecast(uint8(passkey),'uint8');		% Password / Key, depending on version plaintext or encrypted. 25 or less characters, NULL terminated. The characters may involve A-Z, a-z, 0-9, and "!?,.-"
	p = encode_CHANGE_OPERATOR_CONTROL_v1_0(S);
return
