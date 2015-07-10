%%%%  case: 35
%%~ The RAW values of the RC channels received. The standard PPM modulation is as follows: 
%%~ 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
%%~ might violate this specification.
function p = encodeValues_RC_CHANNELS_RAW_v0_9(chan1_raw,chan2_raw,chan3_raw,chan4_raw,chan5_raw,chan6_raw,chan7_raw,chan8_raw,rssi)
	S.chan1_raw = typecast(uint16(chan1_raw),'uint16');		% RC channel 1 value, in microseconds
	S.chan2_raw = typecast(uint16(chan2_raw),'uint16');		% RC channel 2 value, in microseconds
	S.chan3_raw = typecast(uint16(chan3_raw),'uint16');		% RC channel 3 value, in microseconds
	S.chan4_raw = typecast(uint16(chan4_raw),'uint16');		% RC channel 4 value, in microseconds
	S.chan5_raw = typecast(uint16(chan5_raw),'uint16');		% RC channel 5 value, in microseconds
	S.chan6_raw = typecast(uint16(chan6_raw),'uint16');		% RC channel 6 value, in microseconds
	S.chan7_raw = typecast(uint16(chan7_raw),'uint16');		% RC channel 7 value, in microseconds
	S.chan8_raw = typecast(uint16(chan8_raw),'uint16');		% RC channel 8 value, in microseconds
	S.rssi = typecast(uint8(rssi),'uint8');		% Receive signal strength indicator, 0: 0%, 255: 100%
	p = encode_RC_CHANNELS_RAW_v0_9(S);
return
