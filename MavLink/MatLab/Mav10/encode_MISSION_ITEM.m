%%  case: 39
%%~ Message encoding a mission item. This message is emitted to announce            
%%~      the presence of a mission item and to set a mission item on the system. The 
%%~ mission item can be either in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. 
%%~ Local frame is Z-down, right handed (NED), global frame is Z-up, right 
%%~ handed (ENU). See also http://qgroundcontrol.org/mavlink/waypoint_protocol.
function p = encode_MISSION_ITEM(S)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'seq'}				 ... %% Sequence
		{'frame'}			 ... %% The coordinate system of the MISSION. see MAV_FRAME in mavlink_types.h
		{'command'}			 ... %% The scheduled action for the MISSION. see MAV_CMD in common.xml MAVLink specs
		{'current'}			 ... %% false:0, true:1
		{'autocontinue'}	 ... %% autocontinue to next wp
		{'param1'}			 ... %% PARAM1 / For NAV command MISSIONs: Radius in which the MISSION is accepted as reached, in meters
		{'param2'}			 ... %% PARAM2 / For NAV command MISSIONs: Time that the MAV should stay inside the PARAM1 radius before advancing, in milliseconds
		{'param3'}			 ... %% PARAM3 / For LOITER command MISSIONs: Orbit to circle around the MISSION, in meters. If positive the orbit direction should be clockwise, if negative the orbit direction should be counter-clockwise.
		{'param4'}			 ... %% PARAM4 / For NAV and LOITER command MISSIONs: Yaw orientation in degrees, [0..360] 0 = NORTH
		{'x'}				 ... %% PARAM5 / local: x position, global: latitude
		{'y'}				 ... %% PARAM6 / y position: global: longitude
		{'z'}				 ... %% PARAM7 / z position: global: altitude
		];
	byte = [ 1 1 2 1 2 1 1 4 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint8'} {'uint16'} {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode seq data field
	val = typecast(S.seq,'uint16');
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
