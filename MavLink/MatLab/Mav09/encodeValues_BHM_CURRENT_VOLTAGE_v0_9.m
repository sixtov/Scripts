%%%%  case: 121
%%~ Message that provides Battery Current, Voltage, RPM, and an alert status
function p = encodeValues_BHM_CURRENT_VOLTAGE_v0_9(fwd_mtr_cur,aft_mtr_cur,RPM,llf20v,ula20v,lrf40v,ura40v,llf20c,ula20c,lrf40c,ura40c,alert)
	S.fwd_mtr_cur = typecast(single(fwd_mtr_cur),'single');		% Fwd Motor Current (A)
	S.aft_mtr_cur = typecast(single(aft_mtr_cur),'single');		% Aft Motor Current (A)
	S.RPM = typecast(single(RPM),'single');		% Revolutions. Per Minute
	S.llf20v = typecast(single(llf20v),'single');		% Lower Left Fwd Mtr 20-Volt Battery Voltage (V)
	S.ula20v = typecast(single(ula20v),'single');		% Upper Left Aft Mtr 20-Volt Battery Voltage (V)
	S.lrf40v = typecast(single(lrf40v),'single');		% Lower Right Fwd Mtr 40-Volt Battery Voltage (V)
	S.ura40v = typecast(single(ura40v),'single');		% Upper Right Aft Mtr 40-Volt Battery Voltage (V)
	S.llf20c = typecast(single(llf20c),'single');		% Lower Left Fwd Mtr 20-Volt Battery Current (A)
	S.ula20c = typecast(single(ula20c),'single');		% Upper Left Aft Mtr 20-Volt Battery Current (A)
	S.lrf40c = typecast(single(lrf40c),'single');		% Lower Right Fwd Mtr 40-Volt Battery Current (A)
	S.ura40c = typecast(single(ura40c),'single');		% Upper Right Aft Mtr 40-Volt Battery Current (A)
	S.alert = typecast(single(alert),'single');		% Alert Flag (boolean)
	p = encode_BHM_CURRENT_VOLTAGE_v0_9(S);
return
