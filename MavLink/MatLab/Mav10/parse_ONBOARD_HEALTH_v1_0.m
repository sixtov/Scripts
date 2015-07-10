%%  case: 206
function S = parse_ONBOARD_HEALTH_v1_0(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

