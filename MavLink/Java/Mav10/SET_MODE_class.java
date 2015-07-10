//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: SET_MODE(11)
--------------------------------------
%%~ Set the system mode, as defined by enum MAV_MODE. There is no target component id 
%%~ as the mode is by definition for the overall aircraft, not only for one component.
--------------------------------------
*/
public class SET_MODE_class //implements Loggable
{
	public static final int msgID = 11;
	public short	 target_system;	 	// The system setting the mode
	public short	 base_mode;		 	// The new base mode
	public long	 custom_mode;		 	// The new autopilot-specific mode. This field can be ignored by an autopilot.

	private packet rcvPacket;
	private packet sndPacket;

	public SET_MODE_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
	}

	public SET_MODE_class(SET_MODE_class o)
	{
		target_system = o.target_system;
		base_mode = o.base_mode;
		custom_mode = o.custom_mode;
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

			// int[] mavLen = {1, 1, 4};
			// int[] javLen = {2, 2, 8};

			target_system	= rcvPacket.getShortB();
			base_mode		= rcvPacket.getShortB();
			custom_mode		= rcvPacket.getLongI();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  (short)1
					 ,base_mode
					 ,custom_mode
					 );
	}

	public byte[] encode(
						 short v_base_mode
						,long v_custom_mode
						)
	{
		return encode(
					    (short)1
					 ,v_base_mode
					 ,v_custom_mode
					 );
	}

	public byte[] encode(
						 short v_target_system
						,short v_base_mode
						,long v_custom_mode
						)
	{
		// int[] mavLen = {1, 1, 4};
		// int[] javLen = {2, 2, 8};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putByteS(v_base_mode);	// Add "base_mode" parameter
		sndPacket.putIntL(v_custom_mode);	// Add "custom_mode" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", SET_MODE_target_system"
 				+ ", SET_MODE_base_mode"
 				+ ", SET_MODE_custom_mode"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system
 				+ ", " + base_mode
 				+ ", " + custom_mode
				);
		return param;
	}
}
