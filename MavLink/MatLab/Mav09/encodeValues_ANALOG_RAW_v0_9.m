%%%%  case: 111
%%~ analog channels raw (counts from ADC 0-1024)
function p = encodeValues_ANALOG_RAW_v0_9(chan01,chan02,chan03,chan04,chan05,chan06,chan07,chan08,chan09,chan10,chan11,chan12,chan13,chan14,chan15,chan16,usec)
	S.chan01 = typecast(uint16(chan01),'uint16');		% adc channel_01
	S.chan02 = typecast(uint16(chan02),'uint16');		% adc channel_02
	S.chan03 = typecast(uint16(chan03),'uint16');		% adc channel_03
	S.chan04 = typecast(uint16(chan04),'uint16');		% adc channel_04
	S.chan05 = typecast(uint16(chan05),'uint16');		% adc channel_05
	S.chan06 = typecast(uint16(chan06),'uint16');		% adc channel_06
	S.chan07 = typecast(uint16(chan07),'uint16');		% adc channel_07
	S.chan08 = typecast(uint16(chan08),'uint16');		% adc channel_08
	S.chan09 = typecast(uint16(chan09),'uint16');		% adc channel_09
	S.chan10 = typecast(uint16(chan10),'uint16');		% adc channel_10
	S.chan11 = typecast(uint16(chan11),'uint16');		% adc channel_11
	S.chan12 = typecast(uint16(chan12),'uint16');		% adc channel_12
	S.chan13 = typecast(uint16(chan13),'uint16');		% adc channel_13
	S.chan14 = typecast(uint16(chan14),'uint16');		% adc channel_14
	S.chan15 = typecast(uint16(chan15),'uint16');		% adc channel_15
	S.chan16 = typecast(uint16(chan16),'uint16');		% adc channel_16
	S.usec = typecast(uint64(usec),'uint64');		% time
	p = encode_ANALOG_RAW_v0_9(S);
return
