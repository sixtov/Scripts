%%  case: 166
%%~ Status generated by radio
function p = encode_RADIO(S)
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

	%% Encode rssi data field
	val = typecast(S.rssi,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode remrssi data field
	val = typecast(S.remrssi,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode txbuf data field
	val = typecast(S.txbuf,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode noise data field
	val = typecast(S.noise,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode remnoise data field
	val = typecast(S.remnoise,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode rxerrors data field
	val = typecast(S.rxerrors,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode fixed data field
	val = typecast(S.fixed,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
