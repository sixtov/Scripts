%%  case: 35
%%~ The RAW values of the RC channels received. The standard PPM modulation is as follows: 
%%~ 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
%%~ might violate this specification.
function p = encode_RC_CHANNELS_RAW_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(17);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(35);
	name = [ ...
		{'chan1_raw'}	 ... %% RC channel 1 value, in microseconds
		{'chan2_raw'}	 ... %% RC channel 2 value, in microseconds
		{'chan3_raw'}	 ... %% RC channel 3 value, in microseconds
		{'chan4_raw'}	 ... %% RC channel 4 value, in microseconds
		{'chan5_raw'}	 ... %% RC channel 5 value, in microseconds
		{'chan6_raw'}	 ... %% RC channel 6 value, in microseconds
		{'chan7_raw'}	 ... %% RC channel 7 value, in microseconds
		{'chan8_raw'}	 ... %% RC channel 8 value, in microseconds
		{'rssi'}		 ... %% Receive signal strength indicator, 0: 0%, 255: 100%
		];
	byte = [ 2 2 2 2 2 2 2 2 1 ];
	type = [ {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint8'} ];

	p = [head len pnum sysid id messid];
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

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
