%%%%  case: 36
%%~ The scaled values of the RC channels received. (-100%) -10000, (0%) 0, (100%) 
%%~ 10000
function p = encodeValues_RC_CHANNELS_SCALED_v0_9(chan1_scaled,chan2_scaled,chan3_scaled,chan4_scaled,chan5_scaled,chan6_scaled,chan7_scaled,chan8_scaled,rssi)
	S.chan1_scaled = typecast(int16(chan1_scaled),'int16');		% RC channel 1 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
	S.chan2_scaled = typecast(int16(chan2_scaled),'int16');		% RC channel 2 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
	S.chan3_scaled = typecast(int16(chan3_scaled),'int16');		% RC channel 3 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
	S.chan4_scaled = typecast(int16(chan4_scaled),'int16');		% RC channel 4 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
	S.chan5_scaled = typecast(int16(chan5_scaled),'int16');		% RC channel 5 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
	S.chan6_scaled = typecast(int16(chan6_scaled),'int16');		% RC channel 6 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
	S.chan7_scaled = typecast(int16(chan7_scaled),'int16');		% RC channel 7 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
	S.chan8_scaled = typecast(int16(chan8_scaled),'int16');		% RC channel 8 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
	S.rssi = typecast(uint8(rssi),'uint8');		% Receive signal strength indicator, 0: 0%, 255: 100%
	p = encode_RC_CHANNELS_SCALED_v0_9(S);
return
