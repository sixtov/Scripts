%%  case: 76
%%~ Report status of a command. Includes feedback wether the command was executed
function p = encode_COMMAND_ACK_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(8);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(76);
	name = [ ...
		{'command'}	 ... %% Current airspeed in m/s
		{'result'}	 ... %% 1: Action ACCEPTED and EXECUTED, 1: Action TEMPORARY REJECTED/DENIED, 2: Action PERMANENTLY DENIED, 3: Action UNKNOWN/UNSUPPORTED, 4: Requesting CONFIRMATION
		];
	byte = [ 4 4 ];
	type = [ {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode command data field
	val = typecast(S.command,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode result data field
	val = typecast(S.result,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
