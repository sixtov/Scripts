//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: LOG_DATA(120)
--------------------------------------
%%~ Reply to LOG_REQUEST_DATA
--------------------------------------
*/
public class LOG_DATA_class //implements Loggable
{
	public static final int msgID = 120;
	public int		 id;		 	// Log id (from LOG_ENTRY reply)
	public long	 ofs;		 	// Offset into the log
	public short	 count;	 	// Number of bytes (zero for end of log)
	public short[]	 data = new short[180];		// log data

	private packet rcvPacket;
	private packet sndPacket;

	public LOG_DATA_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public LOG_DATA_class(LOG_DATA_class o)
	{
		id = o.id;
		ofs = o.ofs;
		count = o.count;
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

			// int[] mavLen = {2, 4, 1, 1};
			// int[] javLen = {4, 8, 2, 180};

			id		= rcvPacket.getIntS();
			ofs		= rcvPacket.getLongI();
			count	= rcvPacket.getShortB();
//	ERROR	Parsing 'data' array of 'short' from 'uint8_t[90]'
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  id
					 ,ofs
					 ,count
					 ,data
					 );
	}

	public byte[] encode(
						 int v_id
						,long v_ofs
						,short v_count
						,short[] v_data
						)
	{
		// int[] mavLen = {2, 4, 1, 1};
		// int[] javLen = {4, 8, 2, 180};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putShortI(v_id);	// Add "id" parameter
		sndPacket.putIntL(v_ofs);	// Add "ofs" parameter
		sndPacket.putByteS(v_count);	// Add "count" parameter
//	ERROR	Encoding 'data' array of 'short' from 'uint8_t[90]'
	// Add "data" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", LOG_DATA_id"
 				+ ", LOG_DATA_ofs"
 				+ ", LOG_DATA_count"
 				+ ", LOG_DATA_data"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + id
 				+ ", " + ofs
 				+ ", " + count
 				+ ", " + data
				);
		return param;
	}
}
