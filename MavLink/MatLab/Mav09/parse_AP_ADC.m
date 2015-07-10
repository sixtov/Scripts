%%  case: 153
%%~ raw ADC output
function S = parse_AP_ADC(S,p)
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
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

