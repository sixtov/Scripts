%%  case: 35
%%~ The RAW values of the RC channels received. The standard PPM modulation is as follows: 
%%~ 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
%%~ might violate this specification.
function S = parse_RC_CHANNELS_RAW(S,p)
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
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

