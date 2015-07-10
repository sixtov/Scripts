%%%%  case: 153
%%~ raw ADC output
function p = encodeValues_AP_ADC_v1_0(adc1,adc2,adc3,adc4,adc5,adc6)
	S.adc1 = typecast(uint16(adc1),'uint16');		% ADC output 1
	S.adc2 = typecast(uint16(adc2),'uint16');		% ADC output 2
	S.adc3 = typecast(uint16(adc3),'uint16');		% ADC output 3
	S.adc4 = typecast(uint16(adc4),'uint16');		% ADC output 4
	S.adc5 = typecast(uint16(adc5),'uint16');		% ADC output 5
	S.adc6 = typecast(uint16(adc6),'uint16');		% ADC output 6
	p = encode_AP_ADC_v1_0(S);
return
