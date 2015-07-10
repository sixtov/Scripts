%%%%  case: 65
%%~ The PPM values of the RC channels received. The standard PPM modulation is as follows: 
%%~ 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
%%~ might violate this specification.
function p = encodeValues_RC_CHANNELS_v1_0(time_boot_ms,chancount,chan1_raw,chan2_raw,chan3_raw,chan4_raw,chan5_raw,chan6_raw,chan7_raw,chan8_raw,chan9_raw,chan10_raw,chan11_raw,chan12_raw,chan13_raw,chan14_raw,chan15_raw,chan16_raw,chan17_raw,chan18_raw,rssi)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp (milliseconds since system boot)
	S.chancount = typecast(uint8(chancount),'uint8');		% Total number of RC channels being received. This can be larger than 18, indicating that more channels are available but not given in this message. This value should be 0 when no RC channels are available.
	S.chan1_raw = typecast(uint16(chan1_raw),'uint16');		% RC channel 1 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan2_raw = typecast(uint16(chan2_raw),'uint16');		% RC channel 2 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan3_raw = typecast(uint16(chan3_raw),'uint16');		% RC channel 3 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan4_raw = typecast(uint16(chan4_raw),'uint16');		% RC channel 4 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan5_raw = typecast(uint16(chan5_raw),'uint16');		% RC channel 5 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan6_raw = typecast(uint16(chan6_raw),'uint16');		% RC channel 6 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan7_raw = typecast(uint16(chan7_raw),'uint16');		% RC channel 7 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan8_raw = typecast(uint16(chan8_raw),'uint16');		% RC channel 8 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan9_raw = typecast(uint16(chan9_raw),'uint16');		% RC channel 9 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan10_raw = typecast(uint16(chan10_raw),'uint16');		% RC channel 10 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan11_raw = typecast(uint16(chan11_raw),'uint16');		% RC channel 11 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan12_raw = typecast(uint16(chan12_raw),'uint16');		% RC channel 12 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan13_raw = typecast(uint16(chan13_raw),'uint16');		% RC channel 13 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan14_raw = typecast(uint16(chan14_raw),'uint16');		% RC channel 14 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan15_raw = typecast(uint16(chan15_raw),'uint16');		% RC channel 15 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan16_raw = typecast(uint16(chan16_raw),'uint16');		% RC channel 16 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan17_raw = typecast(uint16(chan17_raw),'uint16');		% RC channel 17 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan18_raw = typecast(uint16(chan18_raw),'uint16');		% RC channel 18 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.rssi = typecast(uint8(rssi),'uint8');		% Receive signal strength indicator, 0: 0%, 100: 100%, 255: invalid/unknown.
	p = encode_RC_CHANNELS_v1_0(S);
return
