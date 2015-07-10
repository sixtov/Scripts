%%  case: 128
%%~ RTK GPS data. Gives information on the relative baseline calculation the GPS is 
%%~ reporting
function S = parse_GPS2_RTK_v1_0(p)
	name = [ ...
		{'time_last_baseline_ms'}	 ... %% Time since boot of last baseline message received in ms.
		{'rtk_receiver_id'}			 ... %% Identification of connected RTK receiver.
		{'wn'}						 ... %% GPS Week Number of last baseline
		{'tow'}						 ... %% GPS Time of Week of last baseline
		{'rtk_health'}				 ... %% GPS-specific health report for RTK data.
		{'rtk_rate'}				 ... %% Rate of baseline messages being received by GPS, in HZ
		{'nsats'}					 ... %% Current number of sats used for RTK calculation.
		{'baseline_coords_type'}	 ... %% Coordinate system of baseline. 0 == ECEF, 1 == NED
		{'baseline_a_mm'}			 ... %% Current baseline in ECEF x or NED north component in mm.
		{'baseline_b_mm'}			 ... %% Current baseline in ECEF y or NED east component in mm.
		{'baseline_c_mm'}			 ... %% Current baseline in ECEF z or NED down component in mm.
		{'accuracy'}				 ... %% Current estimate of baseline accuracy.
		{'iar_num_hypotheses'}		 ... %% Current number of integer ambiguity hypotheses.
		];
	byte = [ 4 1 2 4 1 1 1 1 4 4 4 4 4 ];
	type = [ {'uint32'} {'uint8'} {'uint16'} {'uint32'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'int32'} {'int32'} {'int32'} {'uint32'} {'int32'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

