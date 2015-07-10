%%  case: 121
%%~ Message that provides Battery Current, Voltage, RPM, and an alert status
function p = encode_BHM_CURRENT_VOLTAGE_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(48);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(121);
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

	p = [head len pnum sysid id messid];
	%% Encode fwd_mtr_cur data field
	val = typecast(S.fwd_mtr_cur,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode aft_mtr_cur data field
	val = typecast(S.aft_mtr_cur,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode RPM data field
	val = typecast(S.RPM,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode llf20v data field
	val = typecast(S.llf20v,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ula20v data field
	val = typecast(S.ula20v,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lrf40v data field
	val = typecast(S.lrf40v,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ura40v data field
	val = typecast(S.ura40v,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode llf20c data field
	val = typecast(S.llf20c,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ula20c data field
	val = typecast(S.ula20c,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lrf40c data field
	val = typecast(S.lrf40c,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ura40c data field
	val = typecast(S.ura40c,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode alert data field
	val = typecast(S.alert,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
