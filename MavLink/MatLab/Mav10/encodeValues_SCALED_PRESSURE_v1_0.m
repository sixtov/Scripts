%%%%  case: 29
%%~ The pressure readings for the typical setup of one absolute and differential pressure 
%%~ sensor. The units are as specified in each field.
function p = encodeValues_SCALED_PRESSURE_v1_0(time_boot_ms,press_abs,press_diff,temperature)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp (milliseconds since system boot)
	S.press_abs = typecast(single(press_abs),'single');		% Absolute pressure (hectopascal)
	S.press_diff = typecast(single(press_diff),'single');		% Differential pressure 1 (hectopascal)
	S.temperature = typecast(int16(temperature),'int16');		% Temperature measurement (0.01 degrees celsius)
	p = encode_SCALED_PRESSURE_v1_0(S);
return
