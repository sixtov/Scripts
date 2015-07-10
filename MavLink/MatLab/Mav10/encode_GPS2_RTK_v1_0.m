%%  case: 128
%%~ RTK GPS data. Gives information on the relative baseline calculation the GPS is 
%%~ reporting
function p = encode_GPS2_RTK_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(35);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(128);
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

	p = [head len pnum sysid id messid];
	%% Encode time_last_baseline_ms data field
	val = typecast(S.time_last_baseline_ms,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode rtk_receiver_id data field
	val = typecast(S.rtk_receiver_id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode wn data field
	val = typecast(S.wn,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode tow data field
	val = typecast(S.tow,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode rtk_health data field
	val = typecast(S.rtk_health,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode rtk_rate data field
	val = typecast(S.rtk_rate,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode nsats data field
	val = typecast(S.nsats,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode baseline_coords_type data field
	val = typecast(S.baseline_coords_type,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode baseline_a_mm data field
	val = typecast(S.baseline_a_mm,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode baseline_b_mm data field
	val = typecast(S.baseline_b_mm,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode baseline_c_mm data field
	val = typecast(S.baseline_c_mm,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode accuracy data field
	val = typecast(S.accuracy,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode iar_num_hypotheses data field
	val = typecast(S.iar_num_hypotheses,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
