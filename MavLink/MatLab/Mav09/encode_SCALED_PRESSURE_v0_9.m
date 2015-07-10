%%  case: 38
%%~ The pressure readings for the typical setup of one absolute and differential pressure 
%%~ sensor. The units are as specified in each field.
function p = encode_SCALED_PRESSURE_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(18);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(38);
	name = [ ...
		{'usec'}		 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'press_abs'}	 ... %% Absolute pressure (hectopascal)
		{'press_diff'}	 ... %% Differential pressure 1 (hectopascal)
		{'temperature'}	 ... %% Temperature measurement (0.01 degrees celsius)
		];
	byte = [ 8 4 4 2 ];
	type = [ {'uint64'} {'single'} {'single'} {'int16'} ];

	p = [head len pnum sysid id messid];
	%% Encode usec data field
	val = typecast(S.usec,'uint64');
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

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
