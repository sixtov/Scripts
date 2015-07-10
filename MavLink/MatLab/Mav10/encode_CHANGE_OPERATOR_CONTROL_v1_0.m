%%  case: 5
%%~ Request to control this MAV
function p = encode_CHANGE_OPERATOR_CONTROL_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(28);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(5);
	name = [ ...
		{'target_system'}	 ... %% System the GCS requests control for
		{'control_request'}	 ... %% 0: request control of this MAV, 1: Release control of this MAV
		{'version'}			 ... %% 0: key as plaintext, 1-255: future, different hashing/encryption variants. The GCS should in general use the safest mode possible initially and then gradually move down the encryption level if it gets a NACK message indicating an encryption mismatch.
		{'passkey'}			 ... %% Password / Key, depending on version plaintext or encrypted. 25 or less characters, NULL terminated. The characters may involve A-Z, a-z, 0-9, and "!?,.-"
		];
	byte = [ 1 1 1 25 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode control_request data field
	val = typecast(S.control_request,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode version data field
	val = typecast(S.version,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode passkey data field
	val = typecast(S.passkey,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
