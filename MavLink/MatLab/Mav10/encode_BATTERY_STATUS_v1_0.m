%%  case: 147
%%~ Battery information
function p = encode_BATTERY_STATUS_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(36);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(147);
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

	p = [head len pnum sysid id messid];
	%% Encode id data field
	val = typecast(S.id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode battery_function data field
	val = typecast(S.battery_function,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode type data field
	val = typecast(S.type,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode temperature data field
	val = typecast(S.temperature,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode voltages data field
	val = typecast(S.voltages,'uint16');
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

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
