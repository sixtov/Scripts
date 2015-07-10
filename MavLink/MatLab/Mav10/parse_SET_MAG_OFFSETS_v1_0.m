%%  case: 151
%%~ set the magnetometer offsets
function S = parse_SET_MAG_OFFSETS_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'mag_ofs_x'}		 ... %% magnetometer X offset
		{'mag_ofs_y'}		 ... %% magnetometer Y offset
		{'mag_ofs_z'}		 ... %% magnetometer Z offset
		];
	byte = [ 1 1 2 2 2 ];
	type = [ {'uint8'} {'uint8'} {'int16'} {'int16'} {'int16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

