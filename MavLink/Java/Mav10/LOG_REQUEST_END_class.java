//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: LOG_REQUEST_END(122)
--------------------------------------
%%~ Stop log transfer and resume normal logging
--------------------------------------
*/
public class LOG_REQUEST_END_class //implements Loggable
{
	public static final int msgID = 122;
	public short	 target_system;	 	// System ID
	public short	 target_component; 	// Component ID

	private packet rcvPacket;
	private packet sndPacket;

	public LOG_REQUEST_END_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
		target_component = 1;
	}

	public LOG_REQUEST_END_class(LOG_REQUEST_END_class o)
	{
		target_system = o.target_system;
		target_component = o.target_component;
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

			// int[] mavLen = {1, 1};
			// int[] javLen = {2, 2};

			target_system	= rcvPacket.getShortB();
			target_component	= rcvPacket.getShortB();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  (short)1
					 ,(short)1
					 );
	}

	public byte[] encode(
						 short v_target_system
						,short v_target_component
						)
	{
		// int[] mavLen = {1, 1};
		// int[] javLen = {2, 2};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putByteS(v_target_component);	// Add "target_component" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", LOG_REQUEST_END_target_system"
 				+ ", LOG_REQUEST_END_target_component"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system
 				+ ", " + target_component
				);
		return param;
	}
}
