//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: WATCHDOG_PROCESS_STATUS(182)
--------------------------------------
--------------------------------------
*/
public class WATCHDOG_PROCESS_STATUS_class //implements Loggable
{
	public static final int msgID = 182;
	public int		 watchdog_id;	 	// Watchdog ID
	public int		 process_id;	 	// Process ID
	public short	 state;		 	// Is running / finished / suspended / crashed
	public short	 muted;		 	// Is muted
	public int		 pid;			 	// PID
	public int		 crashes;		 	// Number of crashes

	private packet rcvPacket;
	private packet sndPacket;

	public WATCHDOG_PROCESS_STATUS_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public WATCHDOG_PROCESS_STATUS_class(WATCHDOG_PROCESS_STATUS_class o)
	{
		watchdog_id = o.watchdog_id;
		process_id = o.process_id;
		state = o.state;
		muted = o.muted;
		pid = o.pid;
		crashes = o.crashes;
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

			// int[] mavLen = {2, 2, 1, 1, 4, 2};
			// int[] javLen = {4, 4, 2, 2, 4, 4};

			watchdog_id	= rcvPacket.getIntS();
			process_id	= rcvPacket.getIntS();
			state		= rcvPacket.getShortB();
			muted		= rcvPacket.getShortB();
			pid			= rcvPacket.getInt();
			crashes		= rcvPacket.getIntS();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  watchdog_id
					 ,process_id
					 ,state
					 ,muted
					 ,pid
					 ,crashes
					 );
	}

	public byte[] encode(
						 int v_watchdog_id
						,int v_process_id
						,short v_state
						,short v_muted
						,int v_pid
						,int v_crashes
						)
	{
		// int[] mavLen = {2, 2, 1, 1, 4, 2};
		// int[] javLen = {4, 4, 2, 2, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putShortI(v_watchdog_id);	// Add "watchdog_id" parameter
		sndPacket.putShortI(v_process_id);	// Add "process_id" parameter
		sndPacket.putByteS(v_state);	// Add "state" parameter
		sndPacket.putByteS(v_muted);	// Add "muted" parameter
		sndPacket.putInt(v_pid);	// Add "pid" parameter
		sndPacket.putShortI(v_crashes);	// Add "crashes" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", WATCHDOG_PROCESS_STATUS_watchdog_id"
 				+ ", WATCHDOG_PROCESS_STATUS_process_id"
 				+ ", WATCHDOG_PROCESS_STATUS_state"
 				+ ", WATCHDOG_PROCESS_STATUS_muted"
 				+ ", WATCHDOG_PROCESS_STATUS_pid"
 				+ ", WATCHDOG_PROCESS_STATUS_crashes"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + watchdog_id
 				+ ", " + process_id
 				+ ", " + state
 				+ ", " + muted
 				+ ", " + pid
 				+ ", " + crashes
				);
		return param;
	}
}
