//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: ENCAPSULATED_DATA(131)
--------------------------------------
--------------------------------------
*/
public class ENCAPSULATED_DATA_class //implements Loggable
{
	public static final int msgID = 131;
	public int		 seqnr;	 	// sequence number (starting with 0 on every transmission)
	public short[]	 data = new short[506];		// image data bytes

	private packet rcvPacket;
	private packet sndPacket;

	public ENCAPSULATED_DATA_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public ENCAPSULATED_DATA_class(ENCAPSULATED_DATA_class o)
	{
		seqnr = o.seqnr;
		data = o.data;
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

			// int[] mavLen = {2, 1};
			// int[] javLen = {4, 506};

			seqnr	= rcvPacket.getIntS();
//	ERROR	Parsing 'data' array of 'short' from 'uint8_t[253]'
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  seqnr
					 ,data
					 );
	}

	public byte[] encode(
						 int v_seqnr
						,short[] v_data
						)
	{
		// int[] mavLen = {2, 1};
		// int[] javLen = {4, 506};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putShortI(v_seqnr);	// Add "seqnr" parameter
//	ERROR	Encoding 'data' array of 'short' from 'uint8_t[253]'
	// Add "data" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", ENCAPSULATED_DATA_seqnr"
 				+ ", ENCAPSULATED_DATA_data"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + seqnr
 				+ ", " + data
				);
		return param;
	}
}
