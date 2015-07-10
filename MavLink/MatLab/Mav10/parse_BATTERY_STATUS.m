%%  case: 147
%%~ Transmitte battery informations for a accu pack.
function S = parse_BATTERY_STATUS(S,p)
	name = [ ...
		{'accu_id'}				 ... %% Accupack ID
		{'voltage_cell_1'}		 ... %% Battery voltage of cell 1, in millivolts (1 = 1 millivolt)
		{'voltage_cell_2'}		 ... %% Battery voltage of cell 2, in millivolts (1 = 1 millivolt), -1: no cell
		{'voltage_cell_3'}		 ... %% Battery voltage of cell 3, in millivolts (1 = 1 millivolt), -1: no cell
		{'voltage_cell_4'}		 ... %% Battery voltage of cell 4, in millivolts (1 = 1 millivolt), -1: no cell
		{'voltage_cell_5'}		 ... %% Battery voltage of cell 5, in millivolts (1 = 1 millivolt), -1: no cell
		{'voltage_cell_6'}		 ... %% Battery voltage of cell 6, in millivolts (1 = 1 millivolt), -1: no cell
		{'current_battery'}		 ... %% Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
		{'current_consumed'}	 ... %% Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate
		{'energy_consumed'}		 ... %% Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate
		{'battery_remaining'}	 ... %% Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot does not estimate the remaining battery
		];
	byte = [ 1 2 2 2 2 2 2 2 4 4 1 ];
	type = [ {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'int16'} {'int32'} {'int32'} {'int8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

