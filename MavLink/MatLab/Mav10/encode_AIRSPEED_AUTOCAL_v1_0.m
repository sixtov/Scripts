%%  case: 174
%%~ Airspeed auto-calibration
function p = encode_AIRSPEED_AUTOCAL_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(48);
	sysid = uint8(S.sysid);
	id = uint8(S.id);
	messid = uint8(174);
	name = [ ...
		{'vx'}				 ... %% GPS velocity north m/s
		{'vy'}				 ... %% GPS velocity east m/s
		{'vz'}				 ... %% GPS velocity down m/s
		{'diff_pressure'}	 ... %% Differential pressure pascals
		{'EAS2TAS'}			 ... %% Estimated to true airspeed ratio
		{'ratio'}			 ... %% Airspeed ratio
		{'state_x'}			 ... %% EKF state x
		{'state_y'}			 ... %% EKF state y
		{'state_z'}			 ... %% EKF state z
		{'Pax'}				 ... %% EKF Pax
		{'Pby'}				 ... %% EKF Pby
		{'Pcz'}				 ... %% EKF Pcz
		];
	byte = [ 4 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode vx data field
	val = typecast(S.vx,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vy data field
	val = typecast(S.vy,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vz data field
	val = typecast(S.vz,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode diff_pressure data field
	val = typecast(S.diff_pressure,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode EAS2TAS data field
	val = typecast(S.EAS2TAS,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ratio data field
	val = typecast(S.ratio,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode state_x data field
	val = typecast(S.state_x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode state_y data field
	val = typecast(S.state_y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode state_z data field
	val = typecast(S.state_z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode Pax data field
	val = typecast(S.Pax,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode Pby data field
	val = typecast(S.Pby,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode Pcz data field
	val = typecast(S.Pcz,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
