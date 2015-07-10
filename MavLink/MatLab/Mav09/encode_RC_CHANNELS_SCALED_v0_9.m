%%  case: 36
%%~ The scaled values of the RC channels received. (-100%) -10000, (0%) 0, (100%) 
%%~ 10000
function p = encode_RC_CHANNELS_SCALED_v0_9(S)
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
	messid = uint8(36);
	name = [ ...
		{'chan1_scaled'} ... %% RC channel 1 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'chan2_scaled'} ... %% RC channel 2 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'chan3_scaled'} ... %% RC channel 3 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'chan4_scaled'} ... %% RC channel 4 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'chan5_scaled'} ... %% RC channel 5 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'chan6_scaled'} ... %% RC channel 6 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'chan7_scaled'} ... %% RC channel 7 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'chan8_scaled'} ... %% RC channel 8 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'rssi'}		 ... %% Receive signal strength indicator, 0: 0%, 255: 100%
		];
	byte = [ 2 2 2 2 2 2 2 2 1 ];
	type = [ {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'uint8'} ];

	p = [head len pnum sysid id messid];
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

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
