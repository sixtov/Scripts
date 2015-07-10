%%%%  case: 109
%%~ Status generated by radio
function p = encodeValues_RADIO_STATUS_v1_0(rssi,remrssi,txbuf,noise,remnoise,rxerrors,fixed)
	S.rssi = typecast(uint8(rssi),'uint8');		% local signal strength
	S.remrssi = typecast(uint8(remrssi),'uint8');		% remote signal strength
	S.txbuf = typecast(uint8(txbuf),'uint8');		% how full the tx buffer is as a percentage
	S.noise = typecast(uint8(noise),'uint8');		% background noise level
	S.remnoise = typecast(uint8(remnoise),'uint8');		% remote background noise level
	S.rxerrors = typecast(uint16(rxerrors),'uint16');		% receive errors
	S.fixed = typecast(uint16(fixed),'uint16');		% count of error corrected packets
	p = encode_RADIO_STATUS_v1_0(S);
return
