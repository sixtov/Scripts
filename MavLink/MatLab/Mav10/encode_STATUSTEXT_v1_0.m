%%  case: 253
%%~ Status text message. These messages are printed in yellow in the COMM console of 
%%~ QGroundControl. WARNING: They consume quite some bandwidth, so use only for important 
%%~ status and error messages. If implemented wisely, these messages are buffered 
%%~ on the MCU and sent only at a limited rate (e.g. 10 Hz).
function p = encode_STATUSTEXT_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(51);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(253);
	name = [ ...
		{'severity'} ... %% Severity of status. Relies on the definitions within RFC-5424. See enum MAV_SEVERITY.
		{'text'}	 ... %% Status text message, without null termination character
		];
	byte = [ 1 50 ];
	type = [ {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode severity data field
	val = typecast(S.severity,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode text data field
	val = typecast(S.text,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
