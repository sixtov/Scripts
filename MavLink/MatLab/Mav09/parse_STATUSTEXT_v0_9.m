%%  case: 254
%%~ Status text message. These messages are printed in yellow in the COMM console of 
%%~ QGroundControl. WARNING: They consume quite some bandwidth, so use only for important 
%%~ status and error messages. If implemented wisely, these messages are buffered 
%%~ on the MCU and sent only at a limited rate (e.g. 10 Hz).
function S = parse_STATUSTEXT_v0_9(p)
	name = [ ...
		{'severity'} ... %% Severity of status, 0 = info message, 255 = critical fault
		{'text'}	 ... %% Status text message, without null termination character
		];
	byte = [ 1 50 ];
	type = [ {'uint8'} {'int8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

