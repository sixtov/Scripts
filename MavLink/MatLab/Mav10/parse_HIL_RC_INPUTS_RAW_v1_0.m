%%  case: 92
%%~ Sent from simulation to autopilot. The RAW values of the RC channels received. The 
%%~ standard PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 
%%~ 100%. Individual receivers/transmitters might violate this specification.
function S = parse_HIL_RC_INPUTS_RAW_v1_0(S,p)
	name = [ ...
		{'time_usec'}	 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'chan1_raw'}	 ... %% RC channel 1 value, in microseconds
		{'chan2_raw'}	 ... %% RC channel 2 value, in microseconds
		{'chan3_raw'}	 ... %% RC channel 3 value, in microseconds
		{'chan4_raw'}	 ... %% RC channel 4 value, in microseconds
		{'chan5_raw'}	 ... %% RC channel 5 value, in microseconds
		{'chan6_raw'}	 ... %% RC channel 6 value, in microseconds
		{'chan7_raw'}	 ... %% RC channel 7 value, in microseconds
		{'chan8_raw'}	 ... %% RC channel 8 value, in microseconds
		{'chan9_raw'}	 ... %% RC channel 9 value, in microseconds
		{'chan10_raw'}	 ... %% RC channel 10 value, in microseconds
		{'chan11_raw'}	 ... %% RC channel 11 value, in microseconds
		{'chan12_raw'}	 ... %% RC channel 12 value, in microseconds
		{'rssi'}		 ... %% Receive signal strength indicator, 0: 0%, 255: 100%
		];
	byte = [ 8 2 2 2 2 2 2 2 2 2 2 2 2 1 ];
	type = [ {'uint64'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

