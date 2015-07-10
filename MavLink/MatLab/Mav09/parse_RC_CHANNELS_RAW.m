%%  case: 35
%%~ The RAW values of the RC channels received. The standard PPM modulation is as follows: 
%%~ 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
%%~ might violate this specification.
function S = parse_RC_CHANNELS_RAW(S,p)
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
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

