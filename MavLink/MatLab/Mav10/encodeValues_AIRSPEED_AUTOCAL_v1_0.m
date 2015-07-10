%%%%  case: 174
%%~ Airspeed auto-calibration
function p = encodeValues_AIRSPEED_AUTOCAL_v1_0(vx,vy,vz,diff_pressure,EAS2TAS,ratio,state_x,state_y,state_z,Pax,Pby,Pcz)
	S.vx = typecast(single(vx),'single');		% GPS velocity north m/s
	S.vy = typecast(single(vy),'single');		% GPS velocity east m/s
	S.vz = typecast(single(vz),'single');		% GPS velocity down m/s
	S.diff_pressure = typecast(single(diff_pressure),'single');		% Differential pressure pascals
	S.EAS2TAS = typecast(single(EAS2TAS),'single');		% Estimated to true airspeed ratio
	S.ratio = typecast(single(ratio),'single');		% Airspeed ratio
	S.state_x = typecast(single(state_x),'single');		% EKF state x
	S.state_y = typecast(single(state_y),'single');		% EKF state y
	S.state_z = typecast(single(state_z),'single');		% EKF state z
	S.Pax = typecast(single(Pax),'single');		% EKF Pax
	S.Pby = typecast(single(Pby),'single');		% EKF Pby
	S.Pcz = typecast(single(Pcz),'single');		% EKF Pcz
	p = encode_AIRSPEED_AUTOCAL_v1_0(S);
return
