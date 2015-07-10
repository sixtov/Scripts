%%  case: 29
%%~ The RAW pressure readings for the typical setup of one absolute pressure and one 
%%~ differential pressure sensor. The sensor values should be the raw, UNSCALED ADC 
%%~ values.
function S = parse_RAW_PRESSURE_v0_9(p)
	name = [ ...
		{'usec'}		 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'press_abs'}	 ... %% Absolute pressure (raw)
		{'press_diff1'}	 ... %% Differential pressure 1 (raw)
		{'press_diff2'}	 ... %% Differential pressure 2 (raw)
		{'temperature'}	 ... %% Raw Temperature measurement (raw)
		];
	byte = [ 8 2 2 2 2 ];
	type = [ {'uint64'} {'int16'} {'int16'} {'int16'} {'int16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

