%%  case: 70
%%~ The RAW values of the RC channels sent to the MAV to override info received from 
%%~ the RC radio. A value of UINT16_MAX means no change to that channel. A value of 
%%~ 0 means control of that channel should be released back to the RC radio. The standard 
%%~ PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 
%%~ 100%. Individual receivers/transmitters might violate this specification.
function p = encode_RC_CHANNELS_OVERRIDE(S)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'chan1_raw'}		 ... %% RC channel 1 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan2_raw'}		 ... %% RC channel 2 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan3_raw'}		 ... %% RC channel 3 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan4_raw'}		 ... %% RC channel 4 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan5_raw'}		 ... %% RC channel 5 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan6_raw'}		 ... %% RC channel 6 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan7_raw'}		 ... %% RC channel 7 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan8_raw'}		 ... %% RC channel 8 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		];
	byte = [ 1 1 2 2 2 2 2 2 2 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];

	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan1_raw data field
	val = typecast(S.chan1_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan2_raw data field
	val = typecast(S.chan2_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan3_raw data field
	val = typecast(S.chan3_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan4_raw data field
	val = typecast(S.chan4_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan5_raw data field
	val = typecast(S.chan5_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan6_raw data field
	val = typecast(S.chan6_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan7_raw data field
	val = typecast(S.chan7_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan8_raw data field
	val = typecast(S.chan8_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
