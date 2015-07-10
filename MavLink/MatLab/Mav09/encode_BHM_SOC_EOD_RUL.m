%%  case: 120
%%~ Message that provides Battery End-Of-Discharge(EOD), Remaining-Useful-Life(RUL), 
%%~ and State-Of-Charge(SOC) information
function p = encode_BHM_SOC_EOD_RUL(S)
	name = [ ...
		{'ura_eod'}	 ... %% Upper Right Aft Motor EOD (seconds)
		{'ura_rul'}	 ... %% Upper Right Aft Motor RUL (seconds
		{'ura_soc'}	 ... %% Upper Right Aft Motor SOC (percent)
		{'lrf_eod'}	 ... %% Lower Right Fwd Motor EOD (seconds)
		{'lrf_rul'}	 ... %% Lower Right Fwd Motor RUL (seconds
		{'lrf_soc'}	 ... %% Lower Right Fwd Motor SOC (percent)
		{'ula_eod'}	 ... %% Upper Left Aft Motor EOD (seconds)
		{'ula_rul'}	 ... %% Upper Left Aft Motor RUL (seconds
		{'ula_soc'}	 ... %% Upper Left Aft Motor SOC (percent)
		{'llf_eod'}	 ... %% Lower Left Fwd Motor EOD (seconds)
		{'llf_rul'}	 ... %% Lower Left Fwd Motor RUL (seconds
		{'llf_soc'}	 ... %% Lower Left Fwd Motor SOC (percent)
		];
	byte = [ 4 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	%% Encode ura_eod data field
	val = typecast(S.ura_eod,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ura_rul data field
	val = typecast(S.ura_rul,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ura_soc data field
	val = typecast(S.ura_soc,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lrf_eod data field
	val = typecast(S.lrf_eod,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lrf_rul data field
	val = typecast(S.lrf_rul,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lrf_soc data field
	val = typecast(S.lrf_soc,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ula_eod data field
	val = typecast(S.ula_eod,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ula_rul data field
	val = typecast(S.ula_rul,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ula_soc data field
	val = typecast(S.ula_soc,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode llf_eod data field
	val = typecast(S.llf_eod,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode llf_rul data field
	val = typecast(S.llf_rul,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode llf_soc data field
	val = typecast(S.llf_soc,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
