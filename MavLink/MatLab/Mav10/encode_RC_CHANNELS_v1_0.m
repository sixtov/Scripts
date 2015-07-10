%%  case: 65
%%~ The PPM values of the RC channels received. The standard PPM modulation is as follows: 
%%~ 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
%%~ might violate this specification.
function p = encode_RC_CHANNELS_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(42);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(65);
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'chancount'}	 ... %% Total number of RC channels being received. This can be larger than 18, indicating that more channels are available but not given in this message. This value should be 0 when no RC channels are available.
		{'chan1_raw'}	 ... %% RC channel 1 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan2_raw'}	 ... %% RC channel 2 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan3_raw'}	 ... %% RC channel 3 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan4_raw'}	 ... %% RC channel 4 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan5_raw'}	 ... %% RC channel 5 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan6_raw'}	 ... %% RC channel 6 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan7_raw'}	 ... %% RC channel 7 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan8_raw'}	 ... %% RC channel 8 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan9_raw'}	 ... %% RC channel 9 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan10_raw'}	 ... %% RC channel 10 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan11_raw'}	 ... %% RC channel 11 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan12_raw'}	 ... %% RC channel 12 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan13_raw'}	 ... %% RC channel 13 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan14_raw'}	 ... %% RC channel 14 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan15_raw'}	 ... %% RC channel 15 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan16_raw'}	 ... %% RC channel 16 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan17_raw'}	 ... %% RC channel 17 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan18_raw'}	 ... %% RC channel 18 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'rssi'}		 ... %% Receive signal strength indicator, 0: 0%, 100: 100%, 255: invalid/unknown.
		];
	byte = [ 4 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 ];
	type = [ {'uint32'} {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chancount data field
	val = typecast(S.chancount,'uint8');
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

	%% Encode chan9_raw data field
	val = typecast(S.chan9_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan10_raw data field
	val = typecast(S.chan10_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan11_raw data field
	val = typecast(S.chan11_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan12_raw data field
	val = typecast(S.chan12_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan13_raw data field
	val = typecast(S.chan13_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan14_raw data field
	val = typecast(S.chan14_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan15_raw data field
	val = typecast(S.chan15_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan16_raw data field
	val = typecast(S.chan16_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan17_raw data field
	val = typecast(S.chan17_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan18_raw data field
	val = typecast(S.chan18_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode rssi data field
	val = typecast(S.rssi,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
