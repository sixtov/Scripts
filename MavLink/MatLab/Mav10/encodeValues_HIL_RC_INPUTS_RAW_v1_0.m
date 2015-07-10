%%%%  case: 92
%%~ Sent from simulation to autopilot. The RAW values of the RC channels received. The 
%%~ standard PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 
%%~ 100%. Individual receivers/transmitters might violate this specification.
function p = encodeValues_HIL_RC_INPUTS_RAW_v1_0(time_usec,chan1_raw,chan2_raw,chan3_raw,chan4_raw,chan5_raw,chan6_raw,chan7_raw,chan8_raw,chan9_raw,chan10_raw,chan11_raw,chan12_raw,rssi)
	S.time_usec = typecast(uint64(time_usec),'uint64');		% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
	S.chan1_raw = typecast(uint16(chan1_raw),'uint16');		% RC channel 1 value, in microseconds
	S.chan2_raw = typecast(uint16(chan2_raw),'uint16');		% RC channel 2 value, in microseconds
	S.chan3_raw = typecast(uint16(chan3_raw),'uint16');		% RC channel 3 value, in microseconds
	S.chan4_raw = typecast(uint16(chan4_raw),'uint16');		% RC channel 4 value, in microseconds
	S.chan5_raw = typecast(uint16(chan5_raw),'uint16');		% RC channel 5 value, in microseconds
	S.chan6_raw = typecast(uint16(chan6_raw),'uint16');		% RC channel 6 value, in microseconds
	S.chan7_raw = typecast(uint16(chan7_raw),'uint16');		% RC channel 7 value, in microseconds
	S.chan8_raw = typecast(uint16(chan8_raw),'uint16');		% RC channel 8 value, in microseconds
	S.chan9_raw = typecast(uint16(chan9_raw),'uint16');		% RC channel 9 value, in microseconds
	S.chan10_raw = typecast(uint16(chan10_raw),'uint16');		% RC channel 10 value, in microseconds
	S.chan11_raw = typecast(uint16(chan11_raw),'uint16');		% RC channel 11 value, in microseconds
	S.chan12_raw = typecast(uint16(chan12_raw),'uint16');		% RC channel 12 value, in microseconds
	S.rssi = typecast(uint8(rssi),'uint8');		% Receive signal strength indicator, 0: 0%, 255: 100%
	p = encode_HIL_RC_INPUTS_RAW_v1_0(S);
return
