%%  case: 69
function p = encode_MANUAL_CONTROL_v0_9(S)
	name = [ ...
		{'target'}			 ... %% The system to be controlled
		{'roll'}			 ... %% roll
		{'pitch'}			 ... %% pitch
		{'yaw'}				 ... %% yaw
		{'thrust'}			 ... %% thrust
		{'roll_manual'}		 ... %% roll control enabled auto:0, manual:1
		{'pitch_manual'}	 ... %% pitch auto:0, manual:1
		{'yaw_manual'}		 ... %% yaw auto:0, manual:1
		{'thrust_manual'}	 ... %% thrust auto:0, manual:1
		];
	byte = [ 1 4 4 4 4 1 1 1 1 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];

	p = [];
	%% Encode target data field
	val = typecast(S.target,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode roll data field
	val = typecast(S.roll,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pitch data field
	val = typecast(S.pitch,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yaw data field
	val = typecast(S.yaw,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode thrust data field
	val = typecast(S.thrust,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode roll_manual data field
	val = typecast(S.roll_manual,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pitch_manual data field
	val = typecast(S.pitch_manual,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yaw_manual data field
	val = typecast(S.yaw_manual,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode thrust_manual data field
	val = typecast(S.thrust_manual,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
