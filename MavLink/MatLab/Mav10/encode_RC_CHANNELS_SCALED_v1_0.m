%%  case: 34
%%~ The scaled values of the RC channels received. (-100%) -10000, (0%) 0, (100%) 
%%~ 10000. Channels that are inactive should be set to UINT16_MAX.
function p = encode_RC_CHANNELS_SCALED_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(22);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(34);
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'port'}		 ... %% Servo output port (set of 8 outputs = 1 port). Most MAVs will just use one, but this allows for more than 8 servos.
		{'chan1_scaled'} ... %% RC channel 1 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'chan2_scaled'} ... %% RC channel 2 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'chan3_scaled'} ... %% RC channel 3 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'chan4_scaled'} ... %% RC channel 4 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'chan5_scaled'} ... %% RC channel 5 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'chan6_scaled'} ... %% RC channel 6 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'chan7_scaled'} ... %% RC channel 7 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'chan8_scaled'} ... %% RC channel 8 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'rssi'}		 ... %% Receive signal strength indicator, 0: 0%, 100: 100%, 255: invalid/unknown.
		];
	byte = [ 4 1 2 2 2 2 2 2 2 2 1 ];
	type = [ {'uint32'} {'uint8'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode port data field
	val = typecast(S.port,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan1_scaled data field
	val = typecast(S.chan1_scaled,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan2_scaled data field
	val = typecast(S.chan2_scaled,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan3_scaled data field
	val = typecast(S.chan3_scaled,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan4_scaled data field
	val = typecast(S.chan4_scaled,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan5_scaled data field
	val = typecast(S.chan5_scaled,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan6_scaled data field
	val = typecast(S.chan6_scaled,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan7_scaled data field
	val = typecast(S.chan7_scaled,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode chan8_scaled data field
	val = typecast(S.chan8_scaled,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode rssi data field
	val = typecast(S.rssi,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
