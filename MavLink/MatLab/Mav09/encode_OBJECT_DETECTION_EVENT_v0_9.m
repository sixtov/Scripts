%%  case: 140
%%~ Object has been detected
function p = encode_OBJECT_DETECTION_EVENT_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(36);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(140);
	name = [ ...
		{'time'}		 ... %% Timestamp in milliseconds since system boot
		{'object_id'}	 ... %% Object ID
		{'type'}		 ... %% Object type: 0: image, 1: letter, 2: ground vehicle, 3: air vehicle, 4: surface vehicle, 5: sub-surface vehicle, 6: human, 7: animal
		{'name'}		 ... %% Name of the object as defined by the detector
		{'quality'}		 ... %% Detection quality / confidence. 0: bad, 255: maximum confidence
		{'bearing'}		 ... %% Angle of the object with respect to the body frame in NED coordinates in radians. 0: front
		{'distance'}	 ... %% Ground distance in meters
		];
	byte = [ 4 2 1 20 1 4 4 ];
	type = [ {'uint32'} {'uint16'} {'uint8'} {'uint8'} {'uint8'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode time data field
	val = typecast(S.time,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode object_id data field
	val = typecast(S.object_id,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode type data field
	val = typecast(S.type,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode name data field
	val = typecast(S.name,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode quality data field
	val = typecast(S.quality,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode bearing data field
	val = typecast(S.bearing,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode distance data field
	val = typecast(S.distance,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
