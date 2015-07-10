%%%%  case: 70
%%~ The RAW values of the RC channels sent to the MAV to override info received from 
%%~ the RC radio. A value of UINT16_MAX means no change to that channel. A value of 
%%~ 0 means control of that channel should be released back to the RC radio. The standard 
%%~ PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 
%%~ 100%. Individual receivers/transmitters might violate this specification.
function p = encodeValues_RC_CHANNELS_OVERRIDE_v1_0(target_system,target_component,chan1_raw,chan2_raw,chan3_raw,chan4_raw,chan5_raw,chan6_raw,chan7_raw,chan8_raw)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.chan1_raw = typecast(uint16(chan1_raw),'uint16');		% RC channel 1 value, in microseconds. A value of UINT16_MAX means to ignore this field.
	S.chan2_raw = typecast(uint16(chan2_raw),'uint16');		% RC channel 2 value, in microseconds. A value of UINT16_MAX means to ignore this field.
	S.chan3_raw = typecast(uint16(chan3_raw),'uint16');		% RC channel 3 value, in microseconds. A value of UINT16_MAX means to ignore this field.
	S.chan4_raw = typecast(uint16(chan4_raw),'uint16');		% RC channel 4 value, in microseconds. A value of UINT16_MAX means to ignore this field.
	S.chan5_raw = typecast(uint16(chan5_raw),'uint16');		% RC channel 5 value, in microseconds. A value of UINT16_MAX means to ignore this field.
	S.chan6_raw = typecast(uint16(chan6_raw),'uint16');		% RC channel 6 value, in microseconds. A value of UINT16_MAX means to ignore this field.
	S.chan7_raw = typecast(uint16(chan7_raw),'uint16');		% RC channel 7 value, in microseconds. A value of UINT16_MAX means to ignore this field.
	S.chan8_raw = typecast(uint16(chan8_raw),'uint16');		% RC channel 8 value, in microseconds. A value of UINT16_MAX means to ignore this field.
	p = encode_RC_CHANNELS_OVERRIDE_v1_0(S);
return
