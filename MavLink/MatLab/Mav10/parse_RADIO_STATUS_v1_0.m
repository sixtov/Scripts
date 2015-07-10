%%  case: 109
%%~ Status generated by radio
function S = parse_RADIO_STATUS_v1_0(S,p)
	name = [ ...
		{'rssi'}	 ... %% local signal strength
		{'remrssi'}	 ... %% remote signal strength
		{'txbuf'}	 ... %% how full the tx buffer is as a percentage
		{'noise'}	 ... %% background noise level
		{'remnoise'} ... %% remote background noise level
		{'rxerrors'} ... %% receive errors
		{'fixed'}	 ... %% count of error corrected packets
		];
	byte = [ 1 1 1 1 1 2 2 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

