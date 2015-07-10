%%%%  case: 34
%%~ The scaled values of the RC channels received. (-100%) -10000, (0%) 0, (100%) 
%%~ 10000. Channels that are inactive should be set to UINT16_MAX.
function p = encodeValues_RC_CHANNELS_SCALED_v1_0(time_boot_ms,port,chan1_scaled,chan2_scaled,chan3_scaled,chan4_scaled,chan5_scaled,chan6_scaled,chan7_scaled,chan8_scaled,rssi)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp (milliseconds since system boot)
	S.port = typecast(uint8(port),'uint8');		% Servo output port (set of 8 outputs = 1 port). Most MAVs will just use one, but this allows for more than 8 servos.
	S.chan1_scaled = typecast(int16(chan1_scaled),'int16');		% RC channel 1 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
	S.chan2_scaled = typecast(int16(chan2_scaled),'int16');		% RC channel 2 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
	S.chan3_scaled = typecast(int16(chan3_scaled),'int16');		% RC channel 3 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
	S.chan4_scaled = typecast(int16(chan4_scaled),'int16');		% RC channel 4 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
	S.chan5_scaled = typecast(int16(chan5_scaled),'int16');		% RC channel 5 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
	S.chan6_scaled = typecast(int16(chan6_scaled),'int16');		% RC channel 6 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
	S.chan7_scaled = typecast(int16(chan7_scaled),'int16');		% RC channel 7 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
	S.chan8_scaled = typecast(int16(chan8_scaled),'int16');		% RC channel 8 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
	S.rssi = typecast(uint8(rssi),'uint8');		% Receive signal strength indicator, 0: 0%, 100: 100%, 255: invalid/unknown.
	p = encode_RC_CHANNELS_SCALED_v1_0(S);
return
