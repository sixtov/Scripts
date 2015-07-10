%%  case: 254
%%~ Status text message. These messages are printed in yellow in the COMM console of 
%%~ QGroundControl. WARNING: They consume quite some bandwidth, so use only for important 
%%~ status and error messages. If implemented wisely, these messages are buffered 
%%~ on the MCU and sent only at a limited rate (e.g. 10 Hz).
function p = encode_STATUSTEXT_v0_9(S)
	name = [ ...
		{'severity'} ... %% Severity of status, 0 = info message, 255 = critical fault
		{'text'}	 ... %% Status text message, without null termination character
		];
	byte = [ 1 50 ];
	type = [ {'uint8'} {'int8'} ];

	p = [];
	%% Encode severity data field
	val = typecast(S.severity,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode text data field
	val = typecast(S.text,'int8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
