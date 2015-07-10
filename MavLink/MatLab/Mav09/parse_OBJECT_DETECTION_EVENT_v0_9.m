%%  case: 140
%%~ Object has been detected
function S = parse_OBJECT_DETECTION_EVENT_v0_9(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

