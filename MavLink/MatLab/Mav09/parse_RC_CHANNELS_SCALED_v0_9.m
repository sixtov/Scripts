%%  case: 36
%%~ The scaled values of the RC channels received. (-100%) -10000, (0%) 0, (100%) 
%%~ 10000
function S = parse_RC_CHANNELS_SCALED_v0_9(S,p)
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
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

