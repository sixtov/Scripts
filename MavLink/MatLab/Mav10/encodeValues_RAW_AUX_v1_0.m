%%%%  case: 172
function p = encodeValues_RAW_AUX_v1_0(adc1,adc2,adc3,adc4,vbat,temp,baro)
	S.adc1 = typecast(uint16(adc1),'uint16');		% ADC1 (J405 ADC3, LPC2148 AD0.6)
	S.adc2 = typecast(uint16(adc2),'uint16');		% ADC2 (J405 ADC5, LPC2148 AD0.2)
	S.adc3 = typecast(uint16(adc3),'uint16');		% ADC3 (J405 ADC6, LPC2148 AD0.1)
	S.adc4 = typecast(uint16(adc4),'uint16');		% ADC4 (J405 ADC7, LPC2148 AD1.3)
	S.vbat = typecast(uint16(vbat),'uint16');		% Battery voltage
	S.temp = typecast(int16(temp),'int16');		% Temperature (degrees celcius)
	S.baro = typecast(int32(baro),'int32');		% Barometric pressure (hecto Pascal)
	p = encode_RAW_AUX_v1_0(S);
return
