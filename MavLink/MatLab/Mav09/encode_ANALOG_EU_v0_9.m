%%  case: 112
%%~ analog channels EU (Raw counts converted to engineering units, e.g. feet, meters, 
%%~ Amps, degrees, etc)
function p = encode_ANALOG_EU_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(72);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(112);
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
	byte = [ 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 8 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'uint64'} ];

	p = [head len pnum sysid id messid];
	%% Encode chan01 data field
	val = typecast(S.chan01,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan02 data field
	val = typecast(S.chan02,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan03 data field
	val = typecast(S.chan03,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan04 data field
	val = typecast(S.chan04,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan05 data field
	val = typecast(S.chan05,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan06 data field
	val = typecast(S.chan06,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan07 data field
	val = typecast(S.chan07,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan08 data field
	val = typecast(S.chan08,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan09 data field
	val = typecast(S.chan09,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan10 data field
	val = typecast(S.chan10,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan11 data field
	val = typecast(S.chan11,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan12 data field
	val = typecast(S.chan12,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan13 data field
	val = typecast(S.chan13,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan14 data field
	val = typecast(S.chan14,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan15 data field
	val = typecast(S.chan15,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan16 data field
	val = typecast(S.chan16,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode usec data field
	val = typecast(S.usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
