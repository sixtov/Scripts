%%%%  case: 39
%%~ Message encoding a waypoint. This message is emitted to announce      the presence 
%%~ of a waypoint and to set a waypoint on the system. The waypoint can be either 
%%~ in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. Local frame is Z-down, 
%%~ right handed, global frame is Z-up, right handed
function p = encodeValues_WAYPOINT_v0_9(target_system,target_component,seq,frame,command,current,autocontinue,param1,param2,param3,param4,x,y,z)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.seq = typecast(uint16(seq),'uint16');		% Sequence
	S.frame = typecast(uint8(frame),'uint8');		% The coordinate system of the waypoint. see MAV_FRAME in mavlink_types.h
	S.command = typecast(uint8(command),'uint8');		% The scheduled action for the waypoint. see MAV_COMMAND in common.xml MAVLink specs
	S.current = typecast(uint8(current),'uint8');		% false:0, true:1
	S.autocontinue = typecast(uint8(autocontinue),'uint8');		% autocontinue to next wp
	S.param1 = typecast(single(param1),'single');		% PARAM1 / For NAV command waypoints: Radius in which the waypoint is accepted as reached, in meters
	S.param2 = typecast(single(param2),'single');		% PARAM2 / For NAV command waypoints: Time that the MAV should stay inside the PARAM1 radius before advancing, in milliseconds
	S.param3 = typecast(single(param3),'single');		% PARAM3 / For LOITER command waypoints: Orbit to circle around the waypoint, in meters. If positive the orbit direction should be clockwise, if negative the orbit direction should be counter-clockwise.
	S.param4 = typecast(single(param4),'single');		% PARAM4 / For NAV and LOITER command waypoints: Yaw orientation in degrees, [0..360] 0 = NORTH
	S.x = typecast(single(x),'single');		% PARAM5 / local: x position, global: latitude
	S.y = typecast(single(y),'single');		% PARAM6 / y position: global: longitude
	S.z = typecast(single(z),'single');		% PARAM7 / z position: global: altitude
	p = encode_WAYPOINT_v0_9(S);
return
