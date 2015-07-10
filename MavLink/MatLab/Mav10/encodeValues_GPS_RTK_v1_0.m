%%%%  case: 127
%%~ RTK GPS data. Gives information on the relative baseline calculation the GPS is 
%%~ reporting
function p = encodeValues_GPS_RTK_v1_0(time_last_baseline_ms,rtk_receiver_id,wn,tow,rtk_health,rtk_rate,nsats,baseline_coords_type,baseline_a_mm,baseline_b_mm,baseline_c_mm,accuracy,iar_num_hypotheses)
	S.time_last_baseline_ms = typecast(uint32(time_last_baseline_ms),'uint32');		% Time since boot of last baseline message received in ms.
	S.rtk_receiver_id = typecast(uint8(rtk_receiver_id),'uint8');		% Identification of connected RTK receiver.
	S.wn = typecast(uint16(wn),'uint16');		% GPS Week Number of last baseline
	S.tow = typecast(uint32(tow),'uint32');		% GPS Time of Week of last baseline
	S.rtk_health = typecast(uint8(rtk_health),'uint8');		% GPS-specific health report for RTK data.
	S.rtk_rate = typecast(uint8(rtk_rate),'uint8');		% Rate of baseline messages being received by GPS, in HZ
	S.nsats = typecast(uint8(nsats),'uint8');		% Current number of sats used for RTK calculation.
	S.baseline_coords_type = typecast(uint8(baseline_coords_type),'uint8');		% Coordinate system of baseline. 0 == ECEF, 1 == NED
	S.baseline_a_mm = typecast(int32(baseline_a_mm),'int32');		% Current baseline in ECEF x or NED north component in mm.
	S.baseline_b_mm = typecast(int32(baseline_b_mm),'int32');		% Current baseline in ECEF y or NED east component in mm.
	S.baseline_c_mm = typecast(int32(baseline_c_mm),'int32');		% Current baseline in ECEF z or NED down component in mm.
	S.accuracy = typecast(uint32(accuracy),'uint32');		% Current estimate of baseline accuracy.
	S.iar_num_hypotheses = typecast(int32(iar_num_hypotheses),'int32');		% Current number of integer ambiguity hypotheses.
	p = encode_GPS_RTK_v1_0(S);
return
