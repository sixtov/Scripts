//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: DEBUG(254)
--------------------------------------
%%~ Send a debug value. The index is used to discriminate between values. These values 
%%~ show up in the plot of QGroundControl as DEBUG N.
--------------------------------------
*/
public class DEBUG_class //implements Loggable
{
	public static final int msgID = 254;
	public long	 time_boot_ms; 	// Timestamp (milliseconds since system boot)
	public short	 ind;			 	// index of debug variable
	public float	 value;		 	// DEBUG value

	private packet rcvPacket;
	private packet sndPacket;

	public DEBUG_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public DEBUG_class(DEBUG_class o)
	{
		time_boot_ms = o.time_boot_ms;
		ind = o.ind;
		value = o.value;
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

			// int[] mavLen = {4, 1, 4};
			// int[] javLen = {8, 2, 4};

			time_boot_ms	= rcvPacket.getLongI();
			ind			= rcvPacket.getShortB();
			value		= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  time_boot_ms
					 ,ind
					 ,value
					 );
	}

	public byte[] encode(
						 long v_time_boot_ms
						,short v_ind
						,float v_value
						)
	{
		// int[] mavLen = {4, 1, 4};
		// int[] javLen = {8, 2, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putIntL(v_time_boot_ms);	// Add "time_boot_ms" parameter
		sndPacket.putByteS(v_ind);	// Add "ind" parameter
		sndPacket.putFloat(v_value);	// Add "value" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", DEBUG_time_boot_ms"
 				+ ", DEBUG_ind"
 				+ ", DEBUG_value"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + time_boot_ms
 				+ ", " + ind
 				+ ", " + value
				);
		return param;
	}
}
