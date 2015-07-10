%%  case: 172
function p = encode_RAW_AUX_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(16);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(172);
	name = [ ...
		{'adc1'} ... %% ADC1 (J405 ADC3, LPC2148 AD0.6)
		{'adc2'} ... %% ADC2 (J405 ADC5, LPC2148 AD0.2)
		{'adc3'} ... %% ADC3 (J405 ADC6, LPC2148 AD0.1)
		{'adc4'} ... %% ADC4 (J405 ADC7, LPC2148 AD1.3)
		{'vbat'} ... %% Battery voltage
		{'temp'} ... %% Temperature (degrees celcius)
		{'baro'} ... %% Barometric pressure (hecto Pascal)
		];
	byte = [ 2 2 2 2 2 2 4 ];
	type = [ {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'int16'} {'int32'} ];

	p = [head len pnum sysid id messid];
	%% Encode adc1 data field
	val = typecast(S.adc1,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode adc2 data field
	val = typecast(S.adc2,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode adc3 data field
	val = typecast(S.adc3,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode adc4 data field
	val = typecast(S.adc4,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vbat data field
	val = typecast(S.vbat,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode temp data field
	val = typecast(S.temp,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode baro data field
	val = typecast(S.baro,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
