%%  case: 29
%%~ The pressure readings for the typical setup of one absolute and differential pressure 
%%~ sensor. The units are as specified in each field.
function S = parse_SCALED_PRESSURE_v1_0(p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'press_abs'}	 ... %% Absolute pressure (hectopascal)
		{'press_diff'}	 ... %% Differential pressure 1 (hectopascal)
		{'temperature'}	 ... %% Temperature measurement (0.01 degrees celsius)
		];
	byte = [ 4 4 4 2 ];
	type = [ {'uint32'} {'single'} {'single'} {'int16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

