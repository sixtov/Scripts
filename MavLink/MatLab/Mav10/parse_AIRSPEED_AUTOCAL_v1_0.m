%%  case: 174
%%~ Airspeed auto-calibration
function S = parse_AIRSPEED_AUTOCAL_v1_0(p)
	name = [ ...
		{'vx'}				 ... %% GPS velocity north m/s
		{'vy'}				 ... %% GPS velocity east m/s
		{'vz'}				 ... %% GPS velocity down m/s
		{'diff_pressure'}	 ... %% Differential pressure pascals
		{'EAS2TAS'}			 ... %% Estimated to true airspeed ratio
		{'ratio'}			 ... %% Airspeed ratio
		{'state_x'}			 ... %% EKF state x
		{'state_y'}			 ... %% EKF state y
		{'state_z'}			 ... %% EKF state z
		{'Pax'}				 ... %% EKF Pax
		{'Pby'}				 ... %% EKF Pby
		{'Pcz'}				 ... %% EKF Pcz
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

