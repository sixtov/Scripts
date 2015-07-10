%%  case: 140
%%~ Object has been detected
function p = encode_OBJECT_DETECTION_EVENT(S)
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

return
