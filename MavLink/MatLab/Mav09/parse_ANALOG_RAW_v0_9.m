%%  case: 111
%%~ analog channels raw (counts from ADC 0-1024)
function S = parse_ANALOG_RAW_v0_9(p)
	name = [ ...
		{'chan01'}	 ... %% adc channel_01
		{'chan02'}	 ... %% adc channel_02
		{'chan03'}	 ... %% adc channel_03
		{'chan04'}	 ... %% adc channel_04
		{'chan05'}	 ... %% adc channel_05
		{'chan06'}	 ... %% adc channel_06
		{'chan07'}	 ... %% adc channel_07
		{'chan08'}	 ... %% adc channel_08
		{'chan09'}	 ... %% adc channel_09
		{'chan10'}	 ... %% adc channel_10
		{'chan11'}	 ... %% adc channel_11
		{'chan12'}	 ... %% adc channel_12
		{'chan13'}	 ... %% adc channel_13
		{'chan14'}	 ... %% adc channel_14
		{'chan15'}	 ... %% adc channel_15
		{'chan16'}	 ... %% adc channel_16
		{'usec'}	 ... %% time
		];
	byte = [ 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 8 ];
	type = [ {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint64'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

