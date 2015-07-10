%%%%  case: 112
%%~ analog channels EU (Raw counts converted to engineering units, e.g. feet, meters, 
%%~ Amps, degrees, etc)
function p = encodeValues_ANALOG_EU_v0_9(chan01,chan02,chan03,chan04,chan05,chan06,chan07,chan08,chan09,chan10,chan11,chan12,chan13,chan14,chan15,chan16,usec)
	S.chan01 = typecast(single(chan01),'single');		% adc channel_01
	S.chan02 = typecast(single(chan02),'single');		% adc channel_02
	S.chan03 = typecast(single(chan03),'single');		% adc channel_03
	S.chan04 = typecast(single(chan04),'single');		% adc channel_04
	S.chan05 = typecast(single(chan05),'single');		% adc channel_05
	S.chan06 = typecast(single(chan06),'single');		% adc channel_06
	S.chan07 = typecast(single(chan07),'single');		% adc channel_07
	S.chan08 = typecast(single(chan08),'single');		% adc channel_08
	S.chan09 = typecast(single(chan09),'single');		% adc channel_09
	S.chan10 = typecast(single(chan10),'single');		% adc channel_10
	S.chan11 = typecast(single(chan11),'single');		% adc channel_11
	S.chan12 = typecast(single(chan12),'single');		% adc channel_12
	S.chan13 = typecast(single(chan13),'single');		% adc channel_13
	S.chan14 = typecast(single(chan14),'single');		% adc channel_14
	S.chan15 = typecast(single(chan15),'single');		% adc channel_15
	S.chan16 = typecast(single(chan16),'single');		% adc channel_16
	S.usec = typecast(uint64(usec),'uint64');		% time
	p = encode_ANALOG_EU_v0_9(S);
return
