%%  case: 250
function p = encode_DEBUG_VECT(S)
	name = [ ...
		{'name'}		 ... %% Name
		{'time_usec'}	 ... %% Timestamp
		{'x'}			 ... %% x
		{'y'}			 ... %% y
		{'z'}			 ... %% z
		];
	byte = [ 10 8 4 4 4 ];
	type = [ {'uint8'} {'uint64'} {'single'} {'single'} {'single'} ];

	%% Encode name data field
	val = typecast(S.name,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode time_usec data field
	val = typecast(S.time_usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode x data field
	val = typecast(S.x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode y data field
	val = typecast(S.y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode z data field
	val = typecast(S.z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
