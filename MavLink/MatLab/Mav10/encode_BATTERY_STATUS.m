%%  case: 147
%%~ Transmitte battery informations for a accu pack.
function p = encode_BATTERY_STATUS(S)
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

	%% Encode accu_id data field
	val = typecast(S.accu_id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode voltage_cell_1 data field
	val = typecast(S.voltage_cell_1,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode voltage_cell_2 data field
	val = typecast(S.voltage_cell_2,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode voltage_cell_3 data field
	val = typecast(S.voltage_cell_3,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode voltage_cell_4 data field
	val = typecast(S.voltage_cell_4,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode voltage_cell_5 data field
	val = typecast(S.voltage_cell_5,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode voltage_cell_6 data field
	val = typecast(S.voltage_cell_6,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode current_battery data field
	val = typecast(S.current_battery,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode current_consumed data field
	val = typecast(S.current_consumed,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode energy_consumed data field
	val = typecast(S.energy_consumed,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode battery_remaining data field
	val = typecast(S.battery_remaining,'int8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
