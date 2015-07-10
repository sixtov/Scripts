%%  case: 154
%%~ Configure on-board Camera Control System.
function S = parse_DIGICAM_CONFIGURE_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'mode'}			 ... %% Mode enumeration from 1 to N //P, TV, AV, M, Etc (0 means ignore)
		{'shutter_speed'}	 ... %% Divisor number //e.g. 1000 means 1/1000 (0 means ignore)
		{'aperture'}		 ... %% F stop number x 10 //e.g. 28 means 2.8 (0 means ignore)
		{'iso'}				 ... %% ISO enumeration from 1 to N //e.g. 80, 100, 200, Etc (0 means ignore)
		{'exposure_type'}	 ... %% Exposure type enumeration from 1 to N (0 means ignore)
		{'command_id'}		 ... %% Command Identity (incremental loop: 0 to 255)//A command sent multiple times will be executed or pooled just once
		{'engine_cut_off'}	 ... %% Main engine cut-off time before camera trigger in seconds/10 (0 means no cut-off)
		{'extra_param'}		 ... %% Extra parameters enumeration (0 means ignore)
		{'extra_value'}		 ... %% Correspondent value to given extra_param
		];
	byte = [ 1 1 1 2 1 1 1 1 1 1 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

