%%  case: 165
%%~ Status of key hardware
function p = encode_HWSTATUS_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(3);
	sysid = uint8(S.sysid);
	id = uint8(S.id);
	messid = uint8(165);
	name = [ ...
		{'Vcc'}		 ... %% board voltage (mV)
		{'I2Cerr'}	 ... %% I2C error count
		];
	byte = [ 2 1 ];
	type = [ {'uint16'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode Vcc data field
	val = typecast(S.Vcc,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode I2Cerr data field
	val = typecast(S.I2Cerr,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
