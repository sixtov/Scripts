%%%%  case: 29
%%~ The RAW pressure readings for the typical setup of one absolute pressure and one 
%%~ differential pressure sensor. The sensor values should be the raw, UNSCALED ADC 
%%~ values.
function p = encodeValues_RAW_PRESSURE_v0_9(usec,press_abs,press_diff1,press_diff2,temperature)
	S.usec = typecast(uint64(usec),'uint64');		% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
	S.press_abs = typecast(int16(press_abs),'int16');		% Absolute pressure (raw)
	S.press_diff1 = typecast(int16(press_diff1),'int16');		% Differential pressure 1 (raw)
	S.press_diff2 = typecast(int16(press_diff2),'int16');		% Differential pressure 2 (raw)
	S.temperature = typecast(int16(temperature),'int16');		% Raw Temperature measurement (raw)
	p = encode_RAW_PRESSURE_v0_9(S);
return
