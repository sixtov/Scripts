//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: DATA64(171)
--------------------------------------
%%~ Data packet, size 64
--------------------------------------
*/
public class DATA64_class //implements Loggable
{
	public static final int msgID = 171;
	public short	 type; 	// data type
	public short	 len;	 	// data length
	public short[]	 data = new short[128];	// raw data

	private packet rcvPacket;
	private packet sndPacket;

	public DATA64_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public DATA64_class(DATA64_class o)
	{
		type = o.type;
		len = o.len;
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

			// int[] mavLen = {1, 1, 1};
			// int[] javLen = {2, 2, 128};

			type	= rcvPacket.getShortB();
			len	= rcvPacket.getShortB();
//	ERROR	Parsing 'data' array of 'short' from 'uint8_t[64]'
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  type
					 ,len
					 ,data
					 );
	}

	public byte[] encode(
						 short v_type
						,short v_len
						,short[] v_data
						)
	{
		// int[] mavLen = {1, 1, 1};
		// int[] javLen = {2, 2, 128};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_type);	// Add "type" parameter
		sndPacket.putByteS(v_len);	// Add "len" parameter
//	ERROR	Encoding 'data' array of 'short' from 'uint8_t[64]'
	// Add "data" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", DATA64_type"
 				+ ", DATA64_len"
 				+ ", DATA64_data"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + type
 				+ ", " + len
 				+ ", " + data
				);
		return param;
	}
}
