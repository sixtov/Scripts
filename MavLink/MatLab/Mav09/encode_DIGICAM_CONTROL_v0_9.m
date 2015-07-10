%%  case: 155
%%~ Control on-board Camera Control System to take shots.
function p = encode_DIGICAM_CONTROL_v0_9(S)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'session'}			 ... %% 0: stop, 1: start or keep it up //Session control e.g. show/hide lens
		{'zoom_pos'}		 ... %% 1 to N //Zoom's absolute position (0 means ignore)
		{'zoom_step'}		 ... %% -100 to 100 //Zooming step value to offset zoom from the current position
		{'focus_lock'}		 ... %% 0: unlock focus or keep unlocked, 1: lock focus or keep locked, 3: re-lock focus
		{'shot'}			 ... %% 0: ignore, 1: shot or start filming
		{'command_id'}		 ... %% Command Identity (incremental loop: 0 to 255)//A command sent multiple times will be executed or pooled just once
		{'extra_param'}		 ... %% Extra parameters enumeration (0 means ignore)
		{'extra_value'}		 ... %% Correspondent value to given extra_param
		];
	byte = [ 1 1 1 1 1 1 1 1 1 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'int8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'single'} ];

	p = [];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode session data field
	val = typecast(S.session,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zoom_pos data field
	val = typecast(S.zoom_pos,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zoom_step data field
	val = typecast(S.zoom_step,'int8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode focus_lock data field
	val = typecast(S.focus_lock,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode shot data field
	val = typecast(S.shot,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode command_id data field
	val = typecast(S.command_id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode extra_param data field
	val = typecast(S.extra_param,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode extra_value data field
	val = typecast(S.extra_value,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
