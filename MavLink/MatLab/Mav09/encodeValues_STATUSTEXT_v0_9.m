%%%%  case: 254
%%~ Status text message. These messages are printed in yellow in the COMM console of 
%%~ QGroundControl. WARNING: They consume quite some bandwidth, so use only for important 
%%~ status and error messages. If implemented wisely, these messages are buffered 
%%~ on the MCU and sent only at a limited rate (e.g. 10 Hz).
function p = encodeValues_STATUSTEXT_v0_9(severity,text)
	S.severity = typecast(uint8(severity),'uint8');		% Severity of status, 0 = info message, 255 = critical fault
	S.text = typecast(int8(text),'int8');		% Status text message, without null termination character
	p = encode_STATUSTEXT_v0_9(S);
return
