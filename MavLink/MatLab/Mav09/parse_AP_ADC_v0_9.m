%%  case: 153
%%~ raw ADC output
function S = parse_AP_ADC_v0_9(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

