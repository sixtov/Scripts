%%  case: 253
%%~ Status text message. These messages are printed in yellow in the COMM console of 
%%~ QGroundControl. WARNING: They consume quite some bandwidth, so use only for important 
%%~ status and error messages. If implemented wisely, these messages are buffered 
%%~ on the MCU and sent only at a limited rate (e.g. 10 Hz).
function p = encode_STATUSTEXT_v1_0(S)
	name = [ ...
		{'severity'} ... %% Severity of status. Relies on the definitions within RFC-5424. See enum MAV_SEVERITY.
		{'text'}	 ... %% Status text message, without null termination character
		];
	byte = [ 1 50 ];
	type = [ {'uint8'} {'uint8'} ];

	p = [];
	%% Encode severity data field
	val = typecast(S.severity,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode text data field
	val = typecast(S.text,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
