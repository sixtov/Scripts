//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: POINT_OF_INTEREST(191)
--------------------------------------
%%~ Notifies the operator about a point of interest (POI). This can be anything detected 
%%~ by the                 system. This generic message is intented to help interfacing 
%%~ to generic visualizations and to display                 the POI on a map. 
%%~             
--------------------------------------
*/
public class POINT_OF_INTEREST_class //implements Loggable
{
	public static final int msgID = 191;
	public short	 type;				 	// 0: Notice, 1: Warning, 2: Critical, 3: Emergency, 4: Debug
	public short	 color;				 	// 0: blue, 1: yellow, 2: red, 3: orange, 4: green, 5: magenta
	public short	 coordinate_system;	 	// 0: global, 1:local
	public int		 timeout;				 	// 0: no timeout, >1: timeout in seconds
	public float	 x;					 	// X Position
	public float	 y;					 	// Y Position
	public float	 z;					 	// Z Position
	public byte[]	 name = new byte[26];					// POI name

	private packet rcvPacket;
	private packet sndPacket;

	public POINT_OF_INTEREST_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public POINT_OF_INTEREST_class(POINT_OF_INTEREST_class o)
	{
		type = o.type;
		color = o.color;
		coordinate_system = o.coordinate_system;
		timeout = o.timeout;
		x = o.x;
		y = o.y;
		z = o.z;
		name = o.name;
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

			// int[] mavLen = {1, 1, 1, 2, 4, 4, 4, 1};
			// int[] javLen = {2, 2, 2, 4, 4, 4, 4, 26};

			type					= rcvPacket.getShortB();
			color				= rcvPacket.getShortB();
			coordinate_system	= rcvPacket.getShortB();
			timeout				= rcvPacket.getIntS();
			x					= rcvPacket.getFloat();
			y					= rcvPacket.getFloat();
			z					= rcvPacket.getFloat();
			rcvPacket.getByte(name, 0, 26);
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  type
					 ,color
					 ,coordinate_system
					 ,timeout
					 ,x
					 ,y
					 ,z
					 ,name
					 );
	}

	public byte[] encode(
						 short v_type
						,short v_color
						,short v_coordinate_system
						,int v_timeout
						,float v_x
						,float v_y
						,float v_z
						,byte[] v_name
						)
	{
		// int[] mavLen = {1, 1, 1, 2, 4, 4, 4, 1};
		// int[] javLen = {2, 2, 2, 4, 4, 4, 4, 26};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_type);	// Add "type" parameter
		sndPacket.putByteS(v_color);	// Add "color" parameter
		sndPacket.putByteS(v_coordinate_system);	// Add "coordinate_system" parameter
		sndPacket.putShortI(v_timeout);	// Add "timeout" parameter
		sndPacket.putFloat(v_x);	// Add "x" parameter
		sndPacket.putFloat(v_y);	// Add "y" parameter
		sndPacket.putFloat(v_z);	// Add "z" parameter
		sndPacket.putByte(v_name,0,26);	// Add "name" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", POINT_OF_INTEREST_type"
 				+ ", POINT_OF_INTEREST_color"
 				+ ", POINT_OF_INTEREST_coordinate_system"
 				+ ", POINT_OF_INTEREST_timeout"
 				+ ", POINT_OF_INTEREST_x"
 				+ ", POINT_OF_INTEREST_y"
 				+ ", POINT_OF_INTEREST_z"
 				+ ", POINT_OF_INTEREST_name"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + type
 				+ ", " + color
 				+ ", " + coordinate_system
 				+ ", " + timeout
 				+ ", " + x
 				+ ", " + y
 				+ ", " + z
 				+ ", " + name
				);
		return param;
	}
}
