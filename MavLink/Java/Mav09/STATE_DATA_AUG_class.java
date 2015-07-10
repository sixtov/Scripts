//MavLink 0.9

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: STATE_DATA_AUG(117)
--------------------------------------
%%~ Message that provides information about the state of the aircraft
--------------------------------------
*/
public class STATE_DATA_AUG_class //implements Loggable
{
	public static final int msgID = 117;
	public short	 num;		 	// Vehicle number, e.g. 1 for R1, 2 for R2, 3 for R3
	public short	 atloiter; 	// if 0, vehicle is not currently loitering, if 1, vehicle is loitering
	public short	 mode;	 	// mode: MANUAL=0, CIRCLE=1, STABILIZE=2, FLY_BY_WIRE_A=5, FLY_BY_WIRE_B=6, FLY_BY_WIRE_C=7, AUTO=10, RTL=11, LOITER=12, GUIDED=15, INITIALISING=16
	public short	 RC_state; 	// state: OFF=0, ON=1, FAILSAFE=255
	public long	 usec;	 	// time

	private packet rcvPacket;
	private packet sndPacket;

	public STATE_DATA_AUG_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public STATE_DATA_AUG_class(STATE_DATA_AUG_class o)
	{
		num = o.num;
		atloiter = o.atloiter;
		mode = o.mode;
		RC_state = o.RC_state;
		usec = o.usec;
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

			// int[] mavLen = {1, 1, 1, 1, 8};
			// int[] javLen = {2, 2, 2, 2, 8};

			num		= rcvPacket.getShortB();
			atloiter	= rcvPacket.getShortB();
			mode		= rcvPacket.getShortB();
			RC_state	= rcvPacket.getShortB();
			usec		= rcvPacket.getLong();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  num
					 ,atloiter
					 ,mode
					 ,RC_state
					 ,usec
					 );
	}

	public byte[] encode(
						 short v_num
						,short v_atloiter
						,short v_mode
						,short v_RC_state
						,long v_usec
						)
	{
		// int[] mavLen = {1, 1, 1, 1, 8};
		// int[] javLen = {2, 2, 2, 2, 8};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_num);	// Add "num" parameter
		sndPacket.putByteS(v_atloiter);	// Add "atloiter" parameter
		sndPacket.putByteS(v_mode);	// Add "mode" parameter
		sndPacket.putByteS(v_RC_state);	// Add "RC_state" parameter
		sndPacket.putLong(v_usec);	// Add "usec" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", STATE_DATA_AUG_num"
 				+ ", STATE_DATA_AUG_atloiter"
 				+ ", STATE_DATA_AUG_mode"
 				+ ", STATE_DATA_AUG_RC_state"
 				+ ", STATE_DATA_AUG_usec"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + num
 				+ ", " + atloiter
 				+ ", " + mode
 				+ ", " + RC_state
 				+ ", " + usec
				);
		return param;
	}
}
