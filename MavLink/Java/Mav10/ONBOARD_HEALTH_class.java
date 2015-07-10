//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: ONBOARD_HEALTH(206)
--------------------------------------
--------------------------------------
*/
public class ONBOARD_HEALTH_class //implements Loggable
{
	public static final int msgID = 206;
	public long	 uptime;			 	// Uptime of system
	public int		 cpu_freq;		 	// CPU frequency
	public short	 cpu_load;		 	// CPU load in percent
	public short	 ram_usage;		 	// RAM usage in percent
	public float	 ram_total;		 	// RAM size in GiB
	public short	 swap_usage;		 	// Swap usage in percent
	public float	 swap_total;		 	// Swap size in GiB
	public byte	 disk_health;		 	// Disk health (-1: N/A, 0: ERR, 1: RO, 2: RW)
	public short	 disk_usage;		 	// Disk usage in percent
	public float	 disk_total;		 	// Disk total in GiB
	public float	 temp;			 	// Temperature
	public float	 voltage;			 	// Supply voltage V
	public float	 network_load_in;	 	// Network load inbound KiB/s
	public float	 network_load_out; 	// Network load outbound in KiB/s 

	private packet rcvPacket;
	private packet sndPacket;

	public ONBOARD_HEALTH_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public ONBOARD_HEALTH_class(ONBOARD_HEALTH_class o)
	{
		uptime = o.uptime;
		cpu_freq = o.cpu_freq;
		cpu_load = o.cpu_load;
		ram_usage = o.ram_usage;
		ram_total = o.ram_total;
		swap_usage = o.swap_usage;
		swap_total = o.swap_total;
		disk_health = o.disk_health;
		disk_usage = o.disk_usage;
		disk_total = o.disk_total;
		temp = o.temp;
		voltage = o.voltage;
		network_load_in = o.network_load_in;
		network_load_out = o.network_load_out;
	}

	public boolean parse(byte[] b)
	{
		return parse(b, false);
	}

	public boolean parse(byte[] b, boolean valid)
	{
		rcvPacket.load(b);

		boolean pstatus = valid || rcvPacket.isPacket();
		if (pstatus)
		{
			rcvPacket.updateSeqNum();

			// int[] mavLen = {4, 2, 1, 1, 4, 1, 4, 1, 1, 4, 4, 4, 4, 4};
			// int[] javLen = {8, 4, 2, 2, 4, 2, 4, 1, 2, 4, 4, 4, 4, 4};

			uptime			= rcvPacket.getLongI();
			cpu_freq			= rcvPacket.getIntS();
			cpu_load			= rcvPacket.getShortB();
			ram_usage		= rcvPacket.getShortB();
			ram_total		= rcvPacket.getFloat();
			swap_usage		= rcvPacket.getShortB();
			swap_total		= rcvPacket.getFloat();
			disk_health		= rcvPacket.getByte();
			disk_usage		= rcvPacket.getShortB();
			disk_total		= rcvPacket.getFloat();
			temp				= rcvPacket.getFloat();
			voltage			= rcvPacket.getFloat();
			network_load_in	= rcvPacket.getFloat();
			network_load_out	= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  uptime
					 ,cpu_freq
					 ,cpu_load
					 ,ram_usage
					 ,ram_total
					 ,swap_usage
					 ,swap_total
					 ,disk_health
					 ,disk_usage
					 ,disk_total
					 ,temp
					 ,voltage
					 ,network_load_in
					 ,network_load_out
					 );
	}

	public byte[] encode(
						 long v_uptime
						,int v_cpu_freq
						,short v_cpu_load
						,short v_ram_usage
						,float v_ram_total
						,short v_swap_usage
						,float v_swap_total
						,byte v_disk_health
						,short v_disk_usage
						,float v_disk_total
						,float v_temp
						,float v_voltage
						,float v_network_load_in
						,float v_network_load_out
						)
	{
		// int[] mavLen = {4, 2, 1, 1, 4, 1, 4, 1, 1, 4, 4, 4, 4, 4};
		// int[] javLen = {8, 4, 2, 2, 4, 2, 4, 1, 2, 4, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putIntL(v_uptime);	// Add "uptime" parameter
		sndPacket.putShortI(v_cpu_freq);	// Add "cpu_freq" parameter
		sndPacket.putByteS(v_cpu_load);	// Add "cpu_load" parameter
		sndPacket.putByteS(v_ram_usage);	// Add "ram_usage" parameter
		sndPacket.putFloat(v_ram_total);	// Add "ram_total" parameter
		sndPacket.putByteS(v_swap_usage);	// Add "swap_usage" parameter
		sndPacket.putFloat(v_swap_total);	// Add "swap_total" parameter
		sndPacket.putByte(v_disk_health);	// Add "disk_health" parameter
		sndPacket.putByteS(v_disk_usage);	// Add "disk_usage" parameter
		sndPacket.putFloat(v_disk_total);	// Add "disk_total" parameter
		sndPacket.putFloat(v_temp);	// Add "temp" parameter
		sndPacket.putFloat(v_voltage);	// Add "voltage" parameter
		sndPacket.putFloat(v_network_load_in);	// Add "network_load_in" parameter
		sndPacket.putFloat(v_network_load_out);	// Add "network_load_out" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", ONBOARD_HEALTH_uptime"
 				+ ", ONBOARD_HEALTH_cpu_freq"
 				+ ", ONBOARD_HEALTH_cpu_load"
 				+ ", ONBOARD_HEALTH_ram_usage"
 				+ ", ONBOARD_HEALTH_ram_total"
 				+ ", ONBOARD_HEALTH_swap_usage"
 				+ ", ONBOARD_HEALTH_swap_total"
 				+ ", ONBOARD_HEALTH_disk_health"
 				+ ", ONBOARD_HEALTH_disk_usage"
 				+ ", ONBOARD_HEALTH_disk_total"
 				+ ", ONBOARD_HEALTH_temp"
 				+ ", ONBOARD_HEALTH_voltage"
 				+ ", ONBOARD_HEALTH_network_load_in"
 				+ ", ONBOARD_HEALTH_network_load_out"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + uptime
 				+ ", " + cpu_freq
 				+ ", " + cpu_load
 				+ ", " + ram_usage
 				+ ", " + ram_total
 				+ ", " + swap_usage
 				+ ", " + swap_total
 				+ ", " + disk_health
 				+ ", " + disk_usage
 				+ ", " + disk_total
 				+ ", " + temp
 				+ ", " + voltage
 				+ ", " + network_load_in
 				+ ", " + network_load_out
				);
		return param;
	}
}
