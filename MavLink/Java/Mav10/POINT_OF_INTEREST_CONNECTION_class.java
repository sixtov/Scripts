//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: POINT_OF_INTEREST_CONNECTION(192)
--------------------------------------
%%~ Notifies the operator about the connection of two point of interests (POI). This 
%%~ can be anything detected by the                 system. This generic message is 
%%~ intented to help interfacing to generic visualizations and to display          
%%~        the POI on a map.             
--------------------------------------
*/
public class POINT_OF_INTEREST_CONNECTION_class //implements Loggable
{
	public static final int msgID = 192;
	public short	 type;				 	// 0: Notice, 1: Warning, 2: Critical, 3: Emergency, 4: Debug
	public short	 color;				 	// 0: blue, 1: yellow, 2: red, 3: orange, 4: green, 5: magenta
	public short	 coordinate_system;	 	// 0: global, 1:local
	public int		 timeout;				 	// 0: no timeout, >1: timeout in seconds
	public float	 xp1;					 	// X1 Position
	public float	 yp1;					 	// Y1 Position
	public float	 zp1;					 	// Z1 Position
	public float	 xp2;					 	// X2 Position
	public float	 yp2;					 	// Y2 Position
	public float	 zp2;					 	// Z2 Position
	public byte[]	 name = new byte[26];					// POI connection name

	private packet rcvPacket;
	private packet sndPacket;

	public POINT_OF_INTEREST_CONNECTION_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public POINT_OF_INTEREST_CONNECTION_class(POINT_OF_INTEREST_CONNECTION_class o)
	{
		type = o.type;
		color = o.color;
		coordinate_system = o.coordinate_system;
		timeout = o.timeout;
		xp1 = o.xp1;
		yp1 = o.yp1;
		zp1 = o.zp1;
		xp2 = o.xp2;
		yp2 = o.yp2;
		zp2 = o.zp2;
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

			// int[] mavLen = {1, 1, 1, 2, 4, 4, 4, 4, 4, 4, 1};
			// int[] javLen = {2, 2, 2, 4, 4, 4, 4, 4, 4, 4, 26};

			type					= rcvPacket.getShortB();
			color				= rcvPacket.getShortB();
			coordinate_system	= rcvPacket.getShortB();
			timeout				= rcvPacket.getIntS();
			xp1					= rcvPacket.getFloat();
			yp1					= rcvPacket.getFloat();
			zp1					= rcvPacket.getFloat();
			xp2					= rcvPacket.getFloat();
			yp2					= rcvPacket.getFloat();
			zp2					= rcvPacket.getFloat();
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
					 ,xp1
					 ,yp1
					 ,zp1
					 ,xp2
					 ,yp2
					 ,zp2
					 ,name
					 );
	}

	public byte[] encode(
						 short v_type
						,short v_color
						,short v_coordinate_system
						,int v_timeout
						,float v_xp1
						,float v_yp1
						,float v_zp1
						,float v_xp2
						,float v_yp2
						,float v_zp2
						,byte[] v_name
						)
	{
		// int[] mavLen = {1, 1, 1, 2, 4, 4, 4, 4, 4, 4, 1};
		// int[] javLen = {2, 2, 2, 4, 4, 4, 4, 4, 4, 4, 26};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_type);	// Add "type" parameter
		sndPacket.putByteS(v_color);	// Add "color" parameter
		sndPacket.putByteS(v_coordinate_system);	// Add "coordinate_system" parameter
		sndPacket.putShortI(v_timeout);	// Add "timeout" parameter
		sndPacket.putFloat(v_xp1);	// Add "xp1" parameter
		sndPacket.putFloat(v_yp1);	// Add "yp1" parameter
		sndPacket.putFloat(v_zp1);	// Add "zp1" parameter
		sndPacket.putFloat(v_xp2);	// Add "xp2" parameter
		sndPacket.putFloat(v_yp2);	// Add "yp2" parameter
		sndPacket.putFloat(v_zp2);	// Add "zp2" parameter
		sndPacket.putByte(v_name,0,26);	// Add "name" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", POINT_OF_INTEREST_CONNECTION_type"
 				+ ", POINT_OF_INTEREST_CONNECTION_color"
 				+ ", POINT_OF_INTEREST_CONNECTION_coordinate_system"
 				+ ", POINT_OF_INTEREST_CONNECTION_timeout"
 				+ ", POINT_OF_INTEREST_CONNECTION_xp1"
 				+ ", POINT_OF_INTEREST_CONNECTION_yp1"
 				+ ", POINT_OF_INTEREST_CONNECTION_zp1"
 				+ ", POINT_OF_INTEREST_CONNECTION_xp2"
 				+ ", POINT_OF_INTEREST_CONNECTION_yp2"
 				+ ", POINT_OF_INTEREST_CONNECTION_zp2"
 				+ ", POINT_OF_INTEREST_CONNECTION_name"
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
 				+ ", " + xp1
 				+ ", " + yp1
 				+ ", " + zp1
 				+ ", " + xp2
 				+ ", " + yp2
 				+ ", " + zp2
 				+ ", " + name
				);
		return param;
	}
}
