%%  case: 172
function S = parse_RAW_AUX_v1_0(p)
	name = [ ...
		{'adc1'} ... %% ADC1 (J405 ADC3, LPC2148 AD0.6)
		{'adc2'} ... %% ADC2 (J405 ADC5, LPC2148 AD0.2)
		{'adc3'} ... %% ADC3 (J405 ADC6, LPC2148 AD0.1)
		{'adc4'} ... %% ADC4 (J405 ADC7, LPC2148 AD1.3)
		{'vbat'} ... %% Battery voltage
		{'temp'} ... %% Temperature (degrees celcius)
		{'baro'} ... %% Barometric pressure (hecto Pascal)
		];
	byte = [ 2 2 2 2 2 2 4 ];
	type = [ {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'int16'} {'int32'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

