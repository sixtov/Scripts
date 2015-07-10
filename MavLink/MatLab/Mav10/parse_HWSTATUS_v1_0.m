%%  case: 165
%%~ Status of key hardware
function S = parse_HWSTATUS_v1_0(p)
	name = [ ...
		{'Vcc'}		 ... %% board voltage (mV)
		{'I2Cerr'}	 ... %% I2C error count
		];
	byte = [ 2 1 ];
	type = [ {'uint16'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

