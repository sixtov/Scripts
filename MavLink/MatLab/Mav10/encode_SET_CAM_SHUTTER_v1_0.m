%%  case: 151
function p = encode_SET_CAM_SHUTTER_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(11);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(151);
	name = [ ...
		{'cam_no'}		 ... %% Camera id
		{'cam_mode'}	 ... %% Camera mode: 0 = auto, 1 = manual
		{'trigger_pin'}	 ... %% Trigger pin, 0-3 for PtGrey FireFly
		{'interval'}	 ... %% Shutter interval, in microseconds
		{'exposure'}	 ... %% Exposure time, in microseconds
		{'gain'}		 ... %% Camera gain
		];
	byte = [ 1 1 1 2 2 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint16'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode cam_no data field
	val = typecast(S.cam_no,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode cam_mode data field
	val = typecast(S.cam_mode,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode trigger_pin data field
	val = typecast(S.trigger_pin,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode interval data field
	val = typecast(S.interval,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode exposure data field
	val = typecast(S.exposure,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode gain data field
	val = typecast(S.gain,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
