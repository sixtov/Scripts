//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: DEBUG_VECT(250)
--------------------------------------
--------------------------------------
*/
public class DEBUG_VECT_class //implements Loggable
{
	public static final int msgID = 250;
	public byte[]	 name = new byte[10];			// Name
	public long	 time_usec;	 	// Timestamp
	public float	 x;			 	// x
	public float	 y;			 	// y
	public float	 z;			 	// z

	private packet rcvPacket;
	private packet sndPacket;

	public DEBUG_VECT_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public DEBUG_VECT_class(DEBUG_VECT_class o)
	{
		name = o.name;
		time_usec = o.time_usec;
		x = o.x;
		y = o.y;
		z = o.z;
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

			// int[] mavLen = {1, 8, 4, 4, 4};
			// int[] javLen = {10, 8, 4, 4, 4};

			rcvPacket.getByte(name, 0, 10);
			time_usec	= rcvPacket.getLong();
			x			= rcvPacket.getFloat();
			y			= rcvPacket.getFloat();
			z			= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  name
					 ,time_usec
					 ,x
					 ,y
					 ,z
					 );
	}

	public byte[] encode(
						 byte[] v_name
						,long v_time_usec
						,float v_x
						,float v_y
						,float v_z
						)
	{
		// int[] mavLen = {1, 8, 4, 4, 4};
		// int[] javLen = {10, 8, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByte(v_name,0,10);	// Add "name" parameter
		sndPacket.putLong(v_time_usec);	// Add "time_usec" parameter
		sndPacket.putFloat(v_x);	// Add "x" parameter
		sndPacket.putFloat(v_y);	// Add "y" parameter
		sndPacket.putFloat(v_z);	// Add "z" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", DEBUG_VECT_name"
 				+ ", DEBUG_VECT_time_usec"
 				+ ", DEBUG_VECT_x"
 				+ ", DEBUG_VECT_y"
 				+ ", DEBUG_VECT_z"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + name
 				+ ", " + time_usec
 				+ ", " + x
 				+ ", " + y
 				+ ", " + z
				);
		return param;
	}
}
