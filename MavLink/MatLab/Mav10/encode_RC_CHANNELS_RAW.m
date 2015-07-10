%%  case: 35
%%~ The RAW values of the RC channels received. The standard PPM modulation is as follows: 
%%~ 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
%%~ might violate this specification.
function p = encode_RC_CHANNELS_RAW(S)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'port'}		 ... %% Servo output port (set of 8 outputs = 1 port). Most MAVs will just use one, but this allows for more than 8 servos.
		{'chan1_raw'}	 ... %% RC channel 1 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan2_raw'}	 ... %% RC channel 2 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan3_raw'}	 ... %% RC channel 3 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan4_raw'}	 ... %% RC channel 4 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan5_raw'}	 ... %% RC channel 5 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan6_raw'}	 ... %% RC channel 6 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan7_raw'}	 ... %% RC channel 7 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan8_raw'}	 ... %% RC channel 8 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'rssi'}		 ... %% Receive signal strength indicator, 0: 0%, 100: 100%, 255: invalid/unknown.
		];
	byte = [ 4 1 2 2 2 2 2 2 2 2 1 ];
	type = [ {'uint32'} {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint8'} ];

	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode port data field
	val = typecast(S.port,'uint8');
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

	%% Encode rssi data field
	val = typecast(S.rssi,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
