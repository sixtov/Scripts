%%  case: 70
%%~ The RAW values of the RC channels sent to the MAV to override info received from 
%%~ the RC radio. A value of -1 means no change to that channel. A value of 0 means 
%%~ control of that channel should be released back to the RC radio. The standard PPM 
%%~ modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 100%. Individual 
%%~ receivers/transmitters might violate this specification.
function S = parse_RC_CHANNELS_OVERRIDE_v0_9(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'chan1_raw'}		 ... %% RC channel 1 value, in microseconds
		{'chan2_raw'}		 ... %% RC channel 2 value, in microseconds
		{'chan3_raw'}		 ... %% RC channel 3 value, in microseconds
		{'chan4_raw'}		 ... %% RC channel 4 value, in microseconds
		{'chan5_raw'}		 ... %% RC channel 5 value, in microseconds
		{'chan6_raw'}		 ... %% RC channel 6 value, in microseconds
		{'chan7_raw'}		 ... %% RC channel 7 value, in microseconds
		{'chan8_raw'}		 ... %% RC channel 8 value, in microseconds
		];
	byte = [ 1 1 2 2 2 2 2 2 2 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

