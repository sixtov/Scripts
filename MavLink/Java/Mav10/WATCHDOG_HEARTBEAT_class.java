//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: WATCHDOG_HEARTBEAT(180)
--------------------------------------
--------------------------------------
*/
public class WATCHDOG_HEARTBEAT_class //implements Loggable
{
	public static final int msgID = 180;
	public int	 watchdog_id;		 	// Watchdog ID
	public int	 process_count;	 	// Number of processes

	private packet rcvPacket;
	private packet sndPacket;

	public WATCHDOG_HEARTBEAT_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public WATCHDOG_HEARTBEAT_class(WATCHDOG_HEARTBEAT_class o)
	{
		watchdog_id = o.watchdog_id;
		process_count = o.process_count;
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

			// int[] mavLen = {2, 2};
			// int[] javLen = {4, 4};

			watchdog_id		= rcvPacket.getIntS();
			process_count	= rcvPacket.getIntS();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  watchdog_id
					 ,process_count
					 );
	}

	public byte[] encode(
						 int v_watchdog_id
						,int v_process_count
						)
	{
		// int[] mavLen = {2, 2};
		// int[] javLen = {4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putShortI(v_watchdog_id);	// Add "watchdog_id" parameter
		sndPacket.putShortI(v_process_count);	// Add "process_count" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", WATCHDOG_HEARTBEAT_watchdog_id"
 				+ ", WATCHDOG_HEARTBEAT_process_count"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + watchdog_id
 				+ ", " + process_count
				);
		return param;
	}
}
