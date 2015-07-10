%%  case: 206
function p = encode_ONBOARD_HEALTH_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(39);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(206);
	name = [ ...
		{'uptime'}			 ... %% Uptime of system
		{'cpu_freq'}		 ... %% CPU frequency
		{'cpu_load'}		 ... %% CPU load in percent
		{'ram_usage'}		 ... %% RAM usage in percent
		{'ram_total'}		 ... %% RAM size in GiB
		{'swap_usage'}		 ... %% Swap usage in percent
		{'swap_total'}		 ... %% Swap size in GiB
		{'disk_health'}		 ... %% Disk health (-1: N/A, 0: ERR, 1: RO, 2: RW)
		{'disk_usage'}		 ... %% Disk usage in percent
		{'disk_total'}		 ... %% Disk total in GiB
		{'temp'}			 ... %% Temperature
		{'voltage'}			 ... %% Supply voltage V
		{'network_load_in'}	 ... %% Network load inbound KiB/s
		{'network_load_out'} ... %% Network load outbound in KiB/s 
		];
	byte = [ 4 2 1 1 4 1 4 1 1 4 4 4 4 4 ];
	type = [ {'uint32'} {'uint16'} {'uint8'} {'uint8'} {'single'} {'uint8'} {'single'} {'int8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode uptime data field
	val = typecast(S.uptime,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode cpu_freq data field
	val = typecast(S.cpu_freq,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode cpu_load data field
	val = typecast(S.cpu_load,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ram_usage data field
	val = typecast(S.ram_usage,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ram_total data field
	val = typecast(S.ram_total,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode swap_usage data field
	val = typecast(S.swap_usage,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode swap_total data field
	val = typecast(S.swap_total,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode disk_health data field
	val = typecast(S.disk_health,'int8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode disk_usage data field
	val = typecast(S.disk_usage,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode disk_total data field
	val = typecast(S.disk_total,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode temp data field
	val = typecast(S.temp,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode voltage data field
	val = typecast(S.voltage,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode network_load_in data field
	val = typecast(S.network_load_in,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode network_load_out data field
	val = typecast(S.network_load_out,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
