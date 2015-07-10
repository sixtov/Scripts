%%  case: 137
%%~ Barometer readings for 2nd barometer
function p = encode_SCALED_PRESSURE2_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(14);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(137);
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'press_abs'}	 ... %% Absolute pressure (hectopascal)
		{'press_diff'}	 ... %% Differential pressure 1 (hectopascal)
		{'temperature'}	 ... %% Temperature measurement (0.01 degrees celsius)
		];
	byte = [ 4 4 4 2 ];
	type = [ {'uint32'} {'single'} {'single'} {'int16'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode press_abs data field
	val = typecast(S.press_abs,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode press_diff data field
	val = typecast(S.press_diff,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode temperature data field
	val = typecast(S.temperature,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
