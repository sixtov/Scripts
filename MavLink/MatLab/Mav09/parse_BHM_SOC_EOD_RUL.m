%%  case: 120
%%~ Message that provides Battery End-Of-Discharge(EOD), Remaining-Useful-Life(RUL), 
%%~ and State-Of-Charge(SOC) information
function S = parse_BHM_SOC_EOD_RUL(S,p)
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
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

