%%  case: 153
%%~ raw ADC output
function p = encode_AP_ADC_v0_9(S)
	name = [ ...
		{'adc1'} ... %% ADC output 1
		{'adc2'} ... %% ADC output 2
		{'adc3'} ... %% ADC output 3
		{'adc4'} ... %% ADC output 4
		{'adc5'} ... %% ADC output 5
		{'adc6'} ... %% ADC output 6
		];
	byte = [ 2 2 2 2 2 2 ];
	type = [ {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];

	p = [];
	%% Encode adc1 data field
	val = typecast(S.adc1,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode adc2 data field
	val = typecast(S.adc2,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode adc3 data field
	val = typecast(S.adc3,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode adc4 data field
	val = typecast(S.adc4,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode adc5 data field
	val = typecast(S.adc5,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode adc6 data field
	val = typecast(S.adc6,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
