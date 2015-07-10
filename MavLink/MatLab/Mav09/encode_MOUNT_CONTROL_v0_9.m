%%  case: 157
%%~ Message to control a camera mount, directional antenna, etc.
function p = encode_MOUNT_CONTROL_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(15);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(157);
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'input_a'}			 ... %% pitch(deg*100) or lat, depending on mount mode
		{'input_b'}			 ... %% roll(deg*100) or lon depending on mount mode
		{'input_c'}			 ... %% yaw(deg*100) or alt (in cm) depending on mount mode
		{'save_position'}	 ... %% if "1" it will save current trimmed position on EEPROM (just valid for NEUTRAL and LANDING)
		];
	byte = [ 1 1 4 4 4 1 ];
	type = [ {'uint8'} {'uint8'} {'int32'} {'int32'} {'int32'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode input_a data field
	val = typecast(S.input_a,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode input_b data field
	val = typecast(S.input_b,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode input_c data field
	val = typecast(S.input_c,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode save_position data field
	val = typecast(S.save_position,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
