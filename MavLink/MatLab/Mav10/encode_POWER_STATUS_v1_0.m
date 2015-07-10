%%  case: 125
%%~ Power supply status
function p = encode_POWER_STATUS_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(6);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(125);
	name = [ ...
		{'Vcc'}		 ... %% 5V rail voltage in millivolts
		{'Vservo'}	 ... %% servo rail voltage in millivolts
		{'flags'}	 ... %% power supply status flags (see MAV_POWER_STATUS enum)
		];
	byte = [ 2 2 2 ];
	type = [ {'uint16'} {'uint16'} {'uint16'} ];

	p = [head len pnum sysid id messid];
	%% Encode Vcc data field
	val = typecast(S.Vcc,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode Vservo data field
	val = typecast(S.Vservo,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode flags data field
	val = typecast(S.flags,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
