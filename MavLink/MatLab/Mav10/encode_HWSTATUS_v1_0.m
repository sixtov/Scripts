%%  case: 165
%%~ Status of key hardware
function p = encode_HWSTATUS_v1_0(S)
	name = [ ...
		{'Vcc'}		 ... %% board voltage (mV)
		{'I2Cerr'}	 ... %% I2C error count
		];
	byte = [ 2 1 ];
	type = [ {'uint16'} {'uint8'} ];

	p = [];
	%% Encode Vcc data field
	val = typecast(S.Vcc,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode I2Cerr data field
	val = typecast(S.I2Cerr,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
