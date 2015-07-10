%%%%  case: 147
%%~ Battery information
function p = encodeValues_BATTERY_STATUS_v1_0(id,battery_function,type,temperature,voltages,current_battery,current_consumed,energy_consumed,battery_remaining)
	S.id = typecast(uint8(id),'uint8');		% Battery ID
	S.battery_function = typecast(uint8(battery_function),'uint8');		% Function of the battery
	S.type = typecast(uint8(type),'uint8');		% Type (chemistry) of the battery
	S.temperature = typecast(int16(temperature),'int16');		% Temperature of the battery in centi-degrees celsius. INT16_MAX for unknown temperature.
	S.voltages = typecast(uint16(voltages),'uint16');		% Battery voltage of cells, in millivolts (1 = 1 millivolt)
	S.current_battery = typecast(int16(current_battery),'int16');		% Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
	S.current_consumed = typecast(int32(current_consumed),'int32');		% Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate
	S.energy_consumed = typecast(int32(energy_consumed),'int32');		% Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate
	S.battery_remaining = typecast(int8(battery_remaining),'int8');		% Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot does not estimate the remaining battery
	p = encode_BATTERY_STATUS_v1_0(S);
return
