%%  case: 121
%%~ Message that provides Battery Current, Voltage, RPM, and an alert status
function S = parse_BHM_CURRENT_VOLTAGE_v0_9(p)
	name = [ ...
		{'fwd_mtr_cur'}	 ... %% Fwd Motor Current (A)
		{'aft_mtr_cur'}	 ... %% Aft Motor Current (A)
		{'RPM'}			 ... %% Revolutions. Per Minute
		{'llf20v'}		 ... %% Lower Left Fwd Mtr 20-Volt Battery Voltage (V)
		{'ula20v'}		 ... %% Upper Left Aft Mtr 20-Volt Battery Voltage (V)
		{'lrf40v'}		 ... %% Lower Right Fwd Mtr 40-Volt Battery Voltage (V)
		{'ura40v'}		 ... %% Upper Right Aft Mtr 40-Volt Battery Voltage (V)
		{'llf20c'}		 ... %% Lower Left Fwd Mtr 20-Volt Battery Current (A)
		{'ula20c'}		 ... %% Upper Left Aft Mtr 20-Volt Battery Current (A)
		{'lrf40c'}		 ... %% Lower Right Fwd Mtr 40-Volt Battery Current (A)
		{'ura40c'}		 ... %% Upper Right Aft Mtr 40-Volt Battery Current (A)
		{'alert'}		 ... %% Alert Flag (boolean)
		];
	byte = [ 4 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

