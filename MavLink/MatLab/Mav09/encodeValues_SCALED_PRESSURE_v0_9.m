%%%%  case: 38
%%~ The pressure readings for the typical setup of one absolute and differential pressure 
%%~ sensor. The units are as specified in each field.
function p = encodeValues_SCALED_PRESSURE_v0_9(usec,press_abs,press_diff,temperature)
	S.usec = typecast(uint64(usec),'uint64');		% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
	S.press_abs = typecast(single(press_abs),'single');		% Absolute pressure (hectopascal)
	S.press_diff = typecast(single(press_diff),'single');		% Differential pressure 1 (hectopascal)
	S.temperature = typecast(int16(temperature),'int16');		% Temperature measurement (0.01 degrees celsius)
	p = encode_SCALED_PRESSURE_v0_9(S);
return
