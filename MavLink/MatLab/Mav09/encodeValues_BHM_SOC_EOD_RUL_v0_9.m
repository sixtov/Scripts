%%%%  case: 120
%%~ Message that provides Battery End-Of-Discharge(EOD), Remaining-Useful-Life(RUL), 
%%~ and State-Of-Charge(SOC) information
function p = encodeValues_BHM_SOC_EOD_RUL_v0_9(ura_eod,ura_rul,ura_soc,lrf_eod,lrf_rul,lrf_soc,ula_eod,ula_rul,ula_soc,llf_eod,llf_rul,llf_soc)
	S.ura_eod = typecast(single(ura_eod),'single');		% Upper Right Aft Motor EOD (seconds)
	S.ura_rul = typecast(single(ura_rul),'single');		% Upper Right Aft Motor RUL (seconds
	S.ura_soc = typecast(single(ura_soc),'single');		% Upper Right Aft Motor SOC (percent)
	S.lrf_eod = typecast(single(lrf_eod),'single');		% Lower Right Fwd Motor EOD (seconds)
	S.lrf_rul = typecast(single(lrf_rul),'single');		% Lower Right Fwd Motor RUL (seconds
	S.lrf_soc = typecast(single(lrf_soc),'single');		% Lower Right Fwd Motor SOC (percent)
	S.ula_eod = typecast(single(ula_eod),'single');		% Upper Left Aft Motor EOD (seconds)
	S.ula_rul = typecast(single(ula_rul),'single');		% Upper Left Aft Motor RUL (seconds
	S.ula_soc = typecast(single(ula_soc),'single');		% Upper Left Aft Motor SOC (percent)
	S.llf_eod = typecast(single(llf_eod),'single');		% Lower Left Fwd Motor EOD (seconds)
	S.llf_rul = typecast(single(llf_rul),'single');		% Lower Left Fwd Motor RUL (seconds
	S.llf_soc = typecast(single(llf_soc),'single');		% Lower Left Fwd Motor SOC (percent)
	p = encode_BHM_SOC_EOD_RUL_v0_9(S);
return
