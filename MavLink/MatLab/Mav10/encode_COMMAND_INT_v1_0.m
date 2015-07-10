%%  case: 75
%%~ Message encoding a command with parameters as scaled integers. Scaling depends on 
%%~ the actual command value.
function p = encode_COMMAND_INT_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(35);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(75);
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'frame'}			 ... %% The coordinate system of the COMMAND. see MAV_FRAME in mavlink_types.h
		{'command'}			 ... %% The scheduled action for the mission item. see MAV_CMD in common.xml MAVLink specs
		{'current'}			 ... %% false:0, true:1
		{'autocontinue'}	 ... %% autocontinue to next wp
		{'param1'}			 ... %% PARAM1, see MAV_CMD enum
		{'param2'}			 ... %% PARAM2, see MAV_CMD enum
		{'param3'}			 ... %% PARAM3, see MAV_CMD enum
		{'param4'}			 ... %% PARAM4, see MAV_CMD enum
		{'x'}				 ... %% PARAM5 / local: x position in meters * 1e4, global: latitude in degrees * 10^7
		{'y'}				 ... %% PARAM6 / local: y position in meters * 1e4, global: longitude in degrees * 10^7
		{'z'}				 ... %% PARAM7 / z position: global: altitude in meters (relative or absolute, depending on frame.
		];
	byte = [ 1 1 1 2 1 1 4 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'int32'} {'int32'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode frame data field
	val = typecast(S.frame,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode command data field
	val = typecast(S.command,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode current data field
	val = typecast(S.current,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode autocontinue data field
	val = typecast(S.autocontinue,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param1 data field
	val = typecast(S.param1,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param2 data field
	val = typecast(S.param2,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param3 data field
	val = typecast(S.param3,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param4 data field
	val = typecast(S.param4,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode x data field
	val = typecast(S.x,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode y data field
	val = typecast(S.y,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode z data field
	val = typecast(S.z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
