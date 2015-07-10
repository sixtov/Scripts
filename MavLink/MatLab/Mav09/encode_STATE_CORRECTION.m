%%  case: 64
%%~ Corrects the systems state by adding an error correction term to the position and 
%%~ velocity, and by rotating the attitude by a correction angle.
function p = encode_STATE_CORRECTION(S)
	name = [ ...
		{'xErr'}	 ... %% x position error
		{'yErr'}	 ... %% y position error
		{'zErr'}	 ... %% z position error
		{'rollErr'}	 ... %% roll error (radians)
		{'pitchErr'} ... %% pitch error (radians)
		{'yawErr'}	 ... %% yaw error (radians)
		{'vxErr'}	 ... %% x velocity
		{'vyErr'}	 ... %% y velocity
		{'vzErr'}	 ... %% z velocity
		];
	byte = [ 4 4 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	%% Encode xErr data field
	val = typecast(S.xErr,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yErr data field
	val = typecast(S.yErr,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zErr data field
	val = typecast(S.zErr,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode rollErr data field
	val = typecast(S.rollErr,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pitchErr data field
	val = typecast(S.pitchErr,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yawErr data field
	val = typecast(S.yawErr,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vxErr data field
	val = typecast(S.vxErr,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vyErr data field
	val = typecast(S.vyErr,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vzErr data field
	val = typecast(S.vzErr,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
