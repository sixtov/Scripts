//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: PATTERN_DETECTED(190)
--------------------------------------
--------------------------------------
*/
public class PATTERN_DETECTED_class //implements Loggable
{
	public static final int msgID = 190;
	public short	 type;		 	// 0: Pattern, 1: Letter
	public float	 confidence;	 	// Confidence of detection
	public byte[]	 file = new byte[100];			// Pattern file name
	public short	 detected;	 	// Accepted as true detection, 0 no, 1 yes

	private packet rcvPacket;
	private packet sndPacket;

	public PATTERN_DETECTED_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public PATTERN_DETECTED_class(PATTERN_DETECTED_class o)
	{
		type = o.type;
		confidence = o.confidence;
		file = o.file;
		detected = o.detected;
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

			// int[] mavLen = {1, 4, 1, 1};
			// int[] javLen = {2, 4, 100, 2};

			type			= rcvPacket.getShortB();
			confidence	= rcvPacket.getFloat();
			rcvPacket.getByte(file, 0, 100);
			detected		= rcvPacket.getShortB();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  type
					 ,confidence
					 ,file
					 ,detected
					 );
	}

	public byte[] encode(
						 short v_type
						,float v_confidence
						,byte[] v_file
						,short v_detected
						)
	{
		// int[] mavLen = {1, 4, 1, 1};
		// int[] javLen = {2, 4, 100, 2};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_type);	// Add "type" parameter
		sndPacket.putFloat(v_confidence);	// Add "confidence" parameter
		sndPacket.putByte(v_file,0,100);	// Add "file" parameter
		sndPacket.putByteS(v_detected);	// Add "detected" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", PATTERN_DETECTED_type"
 				+ ", PATTERN_DETECTED_confidence"
 				+ ", PATTERN_DETECTED_file"
 				+ ", PATTERN_DETECTED_detected"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + type
 				+ ", " + confidence
 				+ ", " + file
 				+ ", " + detected
				);
		return param;
	}
}
