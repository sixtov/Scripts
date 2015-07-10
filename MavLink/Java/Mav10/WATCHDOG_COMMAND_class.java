//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: WATCHDOG_COMMAND(183)
--------------------------------------
--------------------------------------
*/
public class WATCHDOG_COMMAND_class //implements Loggable
{
	public static final int msgID = 183;
	public short	 target_system_id; 	// Target system ID
	public int		 watchdog_id;		 	// Watchdog ID
	public int		 process_id;		 	// Process ID
	public short	 command_id;		 	// Command ID

	private packet rcvPacket;
	private packet sndPacket;

	public WATCHDOG_COMMAND_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public WATCHDOG_COMMAND_class(WATCHDOG_COMMAND_class o)
	{
		target_system_id = o.target_system_id;
		watchdog_id = o.watchdog_id;
		process_id = o.process_id;
		command_id = o.command_id;
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

			// int[] mavLen = {1, 2, 2, 1};
			// int[] javLen = {2, 4, 4, 2};

			target_system_id	= rcvPacket.getShortB();
			watchdog_id		= rcvPacket.getIntS();
			process_id		= rcvPacket.getIntS();
			command_id		= rcvPacket.getShortB();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  target_system_id
					 ,watchdog_id
					 ,process_id
					 ,command_id
					 );
	}

	public byte[] encode(
						 short v_target_system_id
						,int v_watchdog_id
						,int v_process_id
						,short v_command_id
						)
	{
		// int[] mavLen = {1, 2, 2, 1};
		// int[] javLen = {2, 4, 4, 2};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system_id);	// Add "target_system_id" parameter
		sndPacket.putShortI(v_watchdog_id);	// Add "watchdog_id" parameter
		sndPacket.putShortI(v_process_id);	// Add "process_id" parameter
		sndPacket.putByteS(v_command_id);	// Add "command_id" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", WATCHDOG_COMMAND_target_system_id"
 				+ ", WATCHDOG_COMMAND_watchdog_id"
 				+ ", WATCHDOG_COMMAND_process_id"
 				+ ", WATCHDOG_COMMAND_command_id"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system_id
 				+ ", " + watchdog_id
 				+ ", " + process_id
 				+ ", " + command_id
				);
		return param;
	}
}
