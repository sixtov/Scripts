%%  case: 111
%%~ analog channels raw (counts from ADC 0-1024)
function p = encode_ANALOG_RAW(S)
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

	%% Encode chan01 data field
	val = typecast(S.chan01,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan02 data field
	val = typecast(S.chan02,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan03 data field
	val = typecast(S.chan03,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan04 data field
	val = typecast(S.chan04,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan05 data field
	val = typecast(S.chan05,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan06 data field
	val = typecast(S.chan06,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan07 data field
	val = typecast(S.chan07,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan08 data field
	val = typecast(S.chan08,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan09 data field
	val = typecast(S.chan09,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan10 data field
	val = typecast(S.chan10,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan11 data field
	val = typecast(S.chan11,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan12 data field
	val = typecast(S.chan12,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan13 data field
	val = typecast(S.chan13,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan14 data field
	val = typecast(S.chan14,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan15 data field
	val = typecast(S.chan15,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan16 data field
	val = typecast(S.chan16,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode usec data field
	val = typecast(S.usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
