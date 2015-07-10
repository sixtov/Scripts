%%  case: 70
%%~ The RAW values of the RC channels sent to the MAV to override info received from 
%%~ the RC radio. A value of UINT16_MAX means no change to that channel. A value of 
%%~ 0 means control of that channel should be released back to the RC radio. The standard 
%%~ PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 
%%~ 100%. Individual receivers/transmitters might violate this specification.
function S = parse_RC_CHANNELS_OVERRIDE_v1_0(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'chan1_raw'}		 ... %% RC channel 1 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan2_raw'}		 ... %% RC channel 2 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan3_raw'}		 ... %% RC channel 3 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan4_raw'}		 ... %% RC channel 4 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan5_raw'}		 ... %% RC channel 5 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan6_raw'}		 ... %% RC channel 6 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan7_raw'}		 ... %% RC channel 7 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan8_raw'}		 ... %% RC channel 8 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		];
	byte = [ 1 1 2 2 2 2 2 2 2 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

