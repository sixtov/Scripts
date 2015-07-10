//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: IMAGE_TRIGGER_CONTROL(153)
--------------------------------------
--------------------------------------
*/
public class IMAGE_TRIGGER_CONTROL_class //implements Loggable
{
	public static final int msgID = 153;
	public short	 enable;	 	// 0 to disable, 1 to enable

	private packet rcvPacket;
	private packet sndPacket;

	public IMAGE_TRIGGER_CONTROL_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public IMAGE_TRIGGER_CONTROL_class(IMAGE_TRIGGER_CONTROL_class o)
	{
		enable = o.enable;
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

			// int[] mavLen = {1};
			// int[] javLen = {2};

			enable	= rcvPacket.getShortB();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  enable
					 );
	}

	public byte[] encode(
						 short v_enable
						)
	{
		// int[] mavLen = {1};
		// int[] javLen = {2};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_enable);	// Add "enable" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", IMAGE_TRIGGER_CONTROL_enable"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + enable
				);
		return param;
	}
}
