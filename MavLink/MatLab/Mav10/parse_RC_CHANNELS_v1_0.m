%%  case: 65
%%~ The PPM values of the RC channels received. The standard PPM modulation is as follows: 
%%~ 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
%%~ might violate this specification.
function S = parse_RC_CHANNELS_v1_0(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

