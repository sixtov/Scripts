%%  case: 147
%%~ Battery information
function S = parse_BATTERY_STATUS_v1_0(p)
	name = [ ...
		{'id'}					 ... %% Battery ID
		{'battery_function'}	 ... %% Function of the battery
		{'type'}				 ... %% Type (chemistry) of the battery
		{'temperature'}			 ... %% Temperature of the battery in centi-degrees celsius. INT16_MAX for unknown temperature.
		{'voltages'}			 ... %% Battery voltage of cells, in millivolts (1 = 1 millivolt)
		{'current_battery'}		 ... %% Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
		{'current_consumed'}	 ... %% Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate
		{'energy_consumed'}		 ... %% Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate
		{'battery_remaining'}	 ... %% Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot does not estimate the remaining battery
		];
	byte = [ 1 1 1 2 20 2 4 4 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'int16'} {'uint16'} {'int16'} {'int32'} {'int32'} {'int8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

