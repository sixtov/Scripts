%%%%  case: 35
%%~ The RAW values of the RC channels received. The standard PPM modulation is as follows: 
%%~ 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
%%~ might violate this specification.
function p = encodeValues_RC_CHANNELS_RAW_v1_0(time_boot_ms,port,chan1_raw,chan2_raw,chan3_raw,chan4_raw,chan5_raw,chan6_raw,chan7_raw,chan8_raw,rssi)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp (milliseconds since system boot)
	S.port = typecast(uint8(port),'uint8');		% Servo output port (set of 8 outputs = 1 port). Most MAVs will just use one, but this allows for more than 8 servos.
	S.chan1_raw = typecast(uint16(chan1_raw),'uint16');		% RC channel 1 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan2_raw = typecast(uint16(chan2_raw),'uint16');		% RC channel 2 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan3_raw = typecast(uint16(chan3_raw),'uint16');		% RC channel 3 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan4_raw = typecast(uint16(chan4_raw),'uint16');		% RC channel 4 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan5_raw = typecast(uint16(chan5_raw),'uint16');		% RC channel 5 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan6_raw = typecast(uint16(chan6_raw),'uint16');		% RC channel 6 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan7_raw = typecast(uint16(chan7_raw),'uint16');		% RC channel 7 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.chan8_raw = typecast(uint16(chan8_raw),'uint16');		% RC channel 8 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
	S.rssi = typecast(uint8(rssi),'uint8');		% Receive signal strength indicator, 0: 0%, 100: 100%, 255: invalid/unknown.
	p = encode_RC_CHANNELS_RAW_v1_0(S);
return
