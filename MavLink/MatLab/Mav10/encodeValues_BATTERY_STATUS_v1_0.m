%%%%  case: 147
%%~ Transmitte battery informations for a accu pack.
function p = encodeValues_BATTERY_STATUS_v1_0(accu_id,voltage_cell_1,voltage_cell_2,voltage_cell_3,voltage_cell_4,voltage_cell_5,voltage_cell_6,current_battery,current_consumed,energy_consumed,battery_remaining)
	S.accu_id = typecast(uint8(accu_id),'uint8');		% Accupack ID
	S.voltage_cell_1 = typecast(uint16(voltage_cell_1),'uint16');		% Battery voltage of cell 1, in millivolts (1 = 1 millivolt)
	S.voltage_cell_2 = typecast(uint16(voltage_cell_2),'uint16');		% Battery voltage of cell 2, in millivolts (1 = 1 millivolt), -1: no cell
	S.voltage_cell_3 = typecast(uint16(voltage_cell_3),'uint16');		% Battery voltage of cell 3, in millivolts (1 = 1 millivolt), -1: no cell
	S.voltage_cell_4 = typecast(uint16(voltage_cell_4),'uint16');		% Battery voltage of cell 4, in millivolts (1 = 1 millivolt), -1: no cell
	S.voltage_cell_5 = typecast(uint16(voltage_cell_5),'uint16');		% Battery voltage of cell 5, in millivolts (1 = 1 millivolt), -1: no cell
	S.voltage_cell_6 = typecast(uint16(voltage_cell_6),'uint16');		% Battery voltage of cell 6, in millivolts (1 = 1 millivolt), -1: no cell
	S.current_battery = typecast(int16(current_battery),'int16');		% Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
	S.current_consumed = typecast(int32(current_consumed),'int32');		% Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate
	S.energy_consumed = typecast(int32(energy_consumed),'int32');		% Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate
	S.battery_remaining = typecast(int8(battery_remaining),'int8');		% Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot does not estimate the remaining battery
	p = encode_BATTERY_STATUS_v1_0(S);
return
