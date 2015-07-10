%%  case: 39
%%~ Message encoding a waypoint. This message is emitted to announce      the presence 
%%~ of a waypoint and to set a waypoint on the system. The waypoint can be either 
%%~ in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. Local frame is Z-down, 
%%~ right handed, global frame is Z-up, right handed
function S = parse_WAYPOINT(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'seq'}				 ... %% Sequence
		{'frame'}			 ... %% The coordinate system of the waypoint. see MAV_FRAME in mavlink_types.h
		{'command'}			 ... %% The scheduled action for the waypoint. see MAV_COMMAND in common.xml MAVLink specs
		{'current'}			 ... %% false:0, true:1
		{'autocontinue'}	 ... %% autocontinue to next wp
		{'param1'}			 ... %% PARAM1 / For NAV command waypoints: Radius in which the waypoint is accepted as reached, in meters
		{'param2'}			 ... %% PARAM2 / For NAV command waypoints: Time that the MAV should stay inside the PARAM1 radius before advancing, in milliseconds
		{'param3'}			 ... %% PARAM3 / For LOITER command waypoints: Orbit to circle around the waypoint, in meters. If positive the orbit direction should be clockwise, if negative the orbit direction should be counter-clockwise.
		{'param4'}			 ... %% PARAM4 / For NAV and LOITER command waypoints: Yaw orientation in degrees, [0..360] 0 = NORTH
		{'x'}				 ... %% PARAM5 / local: x position, global: latitude
		{'y'}				 ... %% PARAM6 / y position: global: longitude
		{'z'}				 ... %% PARAM7 / z position: global: altitude
		];
	byte = [ 1 1 2 1 1 1 1 4 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

