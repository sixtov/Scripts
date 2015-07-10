%%  case: 253
%%~ Status text message. These messages are printed in yellow in the COMM console of 
%%~ QGroundControl. WARNING: They consume quite some bandwidth, so use only for important 
%%~ status and error messages. If implemented wisely, these messages are buffered 
%%~ on the MCU and sent only at a limited rate (e.g. 10 Hz).
function S = parse_STATUSTEXT_v1_0(p)
	name = [ ...
		{'severity'} ... %% Severity of status. Relies on the definitions within RFC-5424. See enum MAV_SEVERITY.
		{'text'}	 ... %% Status text message, without null termination character
		];
	byte = [ 1 50 ];
	type = [ {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

