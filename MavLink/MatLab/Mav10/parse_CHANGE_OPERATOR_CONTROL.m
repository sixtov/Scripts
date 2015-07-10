%%  case: 5
%%~ Request to control this MAV
function S = parse_CHANGE_OPERATOR_CONTROL(S,p)
	name = [ ...
		{'target_system'}	 ... %% System the GCS requests control for
		{'control_request'}	 ... %% 0: request control of this MAV, 1: Release control of this MAV
		{'version'}			 ... %% 0: key as plaintext, 1-255: future, different hashing/encryption variants. The GCS should in general use the safest mode possible initially and then gradually move down the encryption level if it gets a NACK message indicating an encryption mismatch.
		{'passkey'}			 ... %% Password / Key, depending on version plaintext or encrypted. 25 or less characters, NULL terminated. The characters may involve A-Z, a-z, 0-9, and "!?,.-"
		];
	byte = [ 1 1 1 25 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

