%%  case: 151
%%~ set the magnetometer offsets
function p = encode_SET_MAG_OFFSETS(S)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'mag_ofs_x'}		 ... %% magnetometer X offset
		{'mag_ofs_y'}		 ... %% magnetometer Y offset
		{'mag_ofs_z'}		 ... %% magnetometer Z offset
		];
	byte = [ 1 1 2 2 2 ];
	type = [ {'uint8'} {'uint8'} {'int16'} {'int16'} {'int16'} ];

	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mag_ofs_x data field
	val = typecast(S.mag_ofs_x,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mag_ofs_y data field
	val = typecast(S.mag_ofs_y,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mag_ofs_z data field
	val = typecast(S.mag_ofs_z,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
