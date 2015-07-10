//MavLink 0.9

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: SET_ALTITUDE(65)
--------------------------------------
--------------------------------------
*/
public class SET_ALTITUDE_class //implements Loggable
{
	public static final int msgID = 65;
	public short	 target;	 	// The system setting the altitude
	public long	 mode;	 	// The new altitude in meters

	private packet rcvPacket;
	private packet sndPacket;

	public SET_ALTITUDE_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public SET_ALTITUDE_class(SET_ALTITUDE_class o)
	{
		target = o.target;
		mode = o.mode;
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

			// int[] mavLen = {1, 4};
			// int[] javLen = {2, 8};

			target	= rcvPacket.getShortB();
			mode		= rcvPacket.getLongI();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  target
					 ,mode
					 );
	}

	public byte[] encode(
						 short v_target
						,long v_mode
						)
	{
		// int[] mavLen = {1, 4};
		// int[] javLen = {2, 8};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target);	// Add "target" parameter
		sndPacket.putIntL(v_mode);	// Add "mode" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", SET_ALTITUDE_target"
 				+ ", SET_ALTITUDE_mode"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target
 				+ ", " + mode
				);
		return param;
	}
}
