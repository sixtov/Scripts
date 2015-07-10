%%  case: 90
%%~ DEPRECATED PACKET! Suffers from missing airspeed fields and singularities due to 
%%~ Euler angles. Please use HIL_STATE_QUATERNION instead. Sent from simulation to 
%%~ autopilot. This packet is useful for high throughput applications such as hardware 
%%~ in the loop simulations.
function p = encode_HIL_STATE(S)
	name = [ ...
		{'time_usec'}	 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'roll'}		 ... %% Roll angle (rad)
		{'pitch'}		 ... %% Pitch angle (rad)
		{'yaw'}			 ... %% Yaw angle (rad)
		{'rollspeed'}	 ... %% Body frame roll / phi angular speed (rad/s)
		{'pitchspeed'}	 ... %% Body frame pitch / theta angular speed (rad/s)
		{'yawspeed'}	 ... %% Body frame yaw / psi angular speed (rad/s)
		{'lat'}			 ... %% Latitude, expressed as * 1E7
		{'lon'}			 ... %% Longitude, expressed as * 1E7
		{'alt'}			 ... %% Altitude in meters, expressed as * 1000 (millimeters)
		{'vx'}			 ... %% Ground X Speed (Latitude), expressed as m/s * 100
		{'vy'}			 ... %% Ground Y Speed (Longitude), expressed as m/s * 100
		{'vz'}			 ... %% Ground Z Speed (Altitude), expressed as m/s * 100
		{'xacc'}		 ... %% X acceleration (mg)
		{'yacc'}		 ... %% Y acceleration (mg)
		{'zacc'}		 ... %% Z acceleration (mg)
		];
	byte = [ 8 4 4 4 4 4 4 4 4 4 2 2 2 2 2 2 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'int32'} {'int32'} {'int32'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} ];

	%% Encode time_usec data field
	val = typecast(S.time_usec,'uint64');
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

	%% Encode rollspeed data field
	val = typecast(S.rollspeed,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pitchspeed data field
	val = typecast(S.pitchspeed,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yawspeed data field
	val = typecast(S.yawspeed,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lat data field
	val = typecast(S.lat,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lon data field
	val = typecast(S.lon,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode alt data field
	val = typecast(S.alt,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vx data field
	val = typecast(S.vx,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vy data field
	val = typecast(S.vy,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vz data field
	val = typecast(S.vz,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode xacc data field
	val = typecast(S.xacc,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yacc data field
	val = typecast(S.yacc,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zacc data field
	val = typecast(S.zacc,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
