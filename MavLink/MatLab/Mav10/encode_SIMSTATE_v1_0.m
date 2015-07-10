%%  case: 164
%%~ Status of simulation environment, if used
function p = encode_SIMSTATE_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(44);
	sysid = uint8(S.sysid);
	id = uint8(S.id);
	messid = uint8(164);
	name = [ ...
		{'roll'}	 ... %% Roll angle (rad)
		{'pitch'}	 ... %% Pitch angle (rad)
		{'yaw'}		 ... %% Yaw angle (rad)
		{'xacc'}	 ... %% X acceleration m/s/s
		{'yacc'}	 ... %% Y acceleration m/s/s
		{'zacc'}	 ... %% Z acceleration m/s/s
		{'xgyro'}	 ... %% Angular speed around X axis rad/s
		{'ygyro'}	 ... %% Angular speed around Y axis rad/s
		{'zgyro'}	 ... %% Angular speed around Z axis rad/s
		{'lat'}		 ... %% Latitude in degrees * 1E7
		{'lng'}		 ... %% Longitude in degrees * 1E7
		];
	byte = [ 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'int32'} {'int32'} ];

	p = [head len pnum sysid id messid];
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

	%% Encode xacc data field
	val = typecast(S.xacc,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yacc data field
	val = typecast(S.yacc,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zacc data field
	val = typecast(S.zacc,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode xgyro data field
	val = typecast(S.xgyro,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ygyro data field
	val = typecast(S.ygyro,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zgyro data field
	val = typecast(S.zgyro,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lat data field
	val = typecast(S.lat,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lng data field
	val = typecast(S.lng,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
