//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: NAMED_VALUE_INT(252)
--------------------------------------
%%~ Send a key-value pair as integer. The use of this message is discouraged for normal 
%%~ packets, but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
--------------------------------------
*/
public class NAMED_VALUE_INT_class //implements Loggable
{
	public static final int msgID = 252;
	public long time_boot_ms; 	// Timestamp (milliseconds since system boot)
	public byte[] name = new byte[10];			// Name of the debug variable
	public int	 value;		 	// Signed integer value

	private packet rcvPacket;
	private packet sndPacket;

	public NAMED_VALUE_INT_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public NAMED_VALUE_INT_class(NAMED_VALUE_INT_class o)
	{
		time_boot_ms = o.time_boot_ms;
		name = o.name;
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
			// int[] javLen = {8, 10, 4};

			time_boot_ms	= rcvPacket.getLongI();
			rcvPacket.getByte(name, 0, 10);
			value		= rcvPacket.getInt();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  time_boot_ms
					 ,name
					 ,value
					 );
	}

	public byte[] encode(
						 long v_time_boot_ms
						,byte[] v_name
						,int v_value
						)
	{
		// int[] mavLen = {4, 1, 4};
		// int[] javLen = {8, 10, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putIntL(v_time_boot_ms);	// Add "time_boot_ms" parameter
		sndPacket.putByte(v_name,0,10);	// Add "name" parameter
		sndPacket.putInt(v_value);	// Add "value" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", NAMED_VALUE_INT_time_boot_ms"
 				+ ", NAMED_VALUE_INT_name"
 				+ ", NAMED_VALUE_INT_value"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + time_boot_ms
 				+ ", " + name
 				+ ", " + value
				);
		return param;
	}
}
