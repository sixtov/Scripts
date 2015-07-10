//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: WATCHDOG_PROCESS_INFO(181)
--------------------------------------
--------------------------------------
*/
public class WATCHDOG_PROCESS_INFO_class //implements Loggable
{
	public static final int msgID = 181;
	public int	 watchdog_id;	 	// Watchdog ID
	public int	 process_id;	 	// Process ID
	public byte[] name = new byte[100];			// Process name
	public byte[] arguments = new byte[147];		// Process arguments
	public int	 timeout;		 	// Timeout (seconds)

	private packet rcvPacket;
	private packet sndPacket;

	public WATCHDOG_PROCESS_INFO_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public WATCHDOG_PROCESS_INFO_class(WATCHDOG_PROCESS_INFO_class o)
	{
		watchdog_id = o.watchdog_id;
		process_id = o.process_id;
		name = o.name;
		arguments = o.arguments;
		timeout = o.timeout;
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

			// int[] mavLen = {2, 2, 1, 1, 4};
			// int[] javLen = {4, 4, 100, 147, 4};

			watchdog_id	= rcvPacket.getIntS();
			process_id	= rcvPacket.getIntS();
			rcvPacket.getByte(name, 0, 100);
			rcvPacket.getByte(arguments, 0, 147);
			timeout		= rcvPacket.getInt();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  watchdog_id
					 ,process_id
					 ,name
					 ,arguments
					 ,timeout
					 );
	}

	public byte[] encode(
						 int v_watchdog_id
						,int v_process_id
						,byte[] v_name
						,byte[] v_arguments
						,int v_timeout
						)
	{
		// int[] mavLen = {2, 2, 1, 1, 4};
		// int[] javLen = {4, 4, 100, 147, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putShortI(v_watchdog_id);	// Add "watchdog_id" parameter
		sndPacket.putShortI(v_process_id);	// Add "process_id" parameter
		sndPacket.putByte(v_name,0,100);	// Add "name" parameter
		sndPacket.putByte(v_arguments,0,147);	// Add "arguments" parameter
		sndPacket.putInt(v_timeout);	// Add "timeout" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", WATCHDOG_PROCESS_INFO_watchdog_id"
 				+ ", WATCHDOG_PROCESS_INFO_process_id"
 				+ ", WATCHDOG_PROCESS_INFO_name"
 				+ ", WATCHDOG_PROCESS_INFO_arguments"
 				+ ", WATCHDOG_PROCESS_INFO_timeout"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + watchdog_id
 				+ ", " + process_id
 				+ ", " + name
 				+ ", " + arguments
 				+ ", " + timeout
				);
		return param;
	}
}
