//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: BRIEF_FEATURE(195)
--------------------------------------
--------------------------------------
*/
public class BRIEF_FEATURE_class //implements Loggable
{
	public static final int msgID = 195;
	public float	 x;						 	// x position in m
	public float	 y;						 	// y position in m
	public float	 z;						 	// z position in m
	public short	 orientation_assignment;	 	// Orientation assignment 0: false, 1:true
	public int		 size;					 	// Size in pixels
	public int		 orientation;				 	// Orientation
	public short[]	 descriptor = new short[64];					// Descriptor
	public float	 response;				 	// Harris operator response at this location

	private packet rcvPacket;
	private packet sndPacket;

	public BRIEF_FEATURE_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public BRIEF_FEATURE_class(BRIEF_FEATURE_class o)
	{
		x = o.x;
		y = o.y;
		z = o.z;
		orientation_assignment = o.orientation_assignment;
		size = o.size;
		orientation = o.orientation;
		descriptor = o.descriptor;
		response = o.response;
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

			// int[] mavLen = {4, 4, 4, 1, 2, 2, 1, 4};
			// int[] javLen = {4, 4, 4, 2, 4, 4, 64, 4};

			x						= rcvPacket.getFloat();
			y						= rcvPacket.getFloat();
			z						= rcvPacket.getFloat();
			orientation_assignment	= rcvPacket.getShortB();
			size						= rcvPacket.getIntS();
			orientation				= rcvPacket.getIntS();
//	ERROR	Parsing 'descriptor' array of 'short' from 'uint8_t[32]'
			response					= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  x
					 ,y
					 ,z
					 ,orientation_assignment
					 ,size
					 ,orientation
					 ,descriptor
					 ,response
					 );
	}

	public byte[] encode(
						 float v_x
						,float v_y
						,float v_z
						,short v_orientation_assignment
						,int v_size
						,int v_orientation
						,short[] v_descriptor
						,float v_response
						)
	{
		// int[] mavLen = {4, 4, 4, 1, 2, 2, 1, 4};
		// int[] javLen = {4, 4, 4, 2, 4, 4, 64, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putFloat(v_x);	// Add "x" parameter
		sndPacket.putFloat(v_y);	// Add "y" parameter
		sndPacket.putFloat(v_z);	// Add "z" parameter
		sndPacket.putByteS(v_orientation_assignment);	// Add "orientation_assignment" parameter
		sndPacket.putShortI(v_size);	// Add "size" parameter
		sndPacket.putShortI(v_orientation);	// Add "orientation" parameter
//	ERROR	Encoding 'descriptor' array of 'short' from 'uint8_t[32]'
	// Add "descriptor" parameter
		sndPacket.putFloat(v_response);	// Add "response" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", BRIEF_FEATURE_x"
 				+ ", BRIEF_FEATURE_y"
 				+ ", BRIEF_FEATURE_z"
 				+ ", BRIEF_FEATURE_orientation_assignment"
 				+ ", BRIEF_FEATURE_size"
 				+ ", BRIEF_FEATURE_orientation"
 				+ ", BRIEF_FEATURE_descriptor"
 				+ ", BRIEF_FEATURE_response"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + x
 				+ ", " + y
 				+ ", " + z
 				+ ", " + orientation_assignment
 				+ ", " + size
 				+ ", " + orientation
 				+ ", " + descriptor
 				+ ", " + response
				);
		return param;
	}
}
