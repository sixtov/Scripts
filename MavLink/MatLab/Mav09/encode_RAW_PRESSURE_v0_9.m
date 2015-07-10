%%  case: 29
%%~ The RAW pressure readings for the typical setup of one absolute pressure and one 
%%~ differential pressure sensor. The sensor values should be the raw, UNSCALED ADC 
%%~ values.
function p = encode_RAW_PRESSURE_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(16);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(29);
	name = [ ...
		{'usec'}		 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'press_abs'}	 ... %% Absolute pressure (raw)
		{'press_diff1'}	 ... %% Differential pressure 1 (raw)
		{'press_diff2'}	 ... %% Differential pressure 2 (raw)
		{'temperature'}	 ... %% Raw Temperature measurement (raw)
		];
	byte = [ 8 2 2 2 2 ];
	type = [ {'uint64'} {'int16'} {'int16'} {'int16'} {'int16'} ];

	p = [head len pnum sysid id messid];
	%% Encode usec data field
	val = typecast(S.usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode press_abs data field
	val = typecast(S.press_abs,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode press_diff1 data field
	val = typecast(S.press_diff1,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode press_diff2 data field
	val = typecast(S.press_diff2,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode temperature data field
	val = typecast(S.temperature,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
