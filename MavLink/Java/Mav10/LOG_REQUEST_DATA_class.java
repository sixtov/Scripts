//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: LOG_REQUEST_DATA(119)
--------------------------------------
%%~ Request a chunk of a log
--------------------------------------
*/
public class LOG_REQUEST_DATA_class //implements Loggable
{
	public static final int msgID = 119;
	public short	 target_system;	 	// System ID
	public short	 target_component; 	// Component ID
	public int		 id;				 	// Log id (from LOG_ENTRY reply)
	public long	 ofs;				 	// Offset into the log
	public long	 count;			 	// Number of bytes

	private packet rcvPacket;
	private packet sndPacket;

	public LOG_REQUEST_DATA_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
		target_component = 1;
	}

	public LOG_REQUEST_DATA_class(LOG_REQUEST_DATA_class o)
	{
		target_system = o.target_system;
		target_component = o.target_component;
		id = o.id;
		ofs = o.ofs;
		count = o.count;
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

			// int[] mavLen = {1, 1, 2, 4, 4};
			// int[] javLen = {2, 2, 4, 8, 8};

			target_system	= rcvPacket.getShortB();
			target_component	= rcvPacket.getShortB();
			id				= rcvPacket.getIntS();
			ofs				= rcvPacket.getLongI();
			count			= rcvPacket.getLongI();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  (short)1
					 ,(short)1
					 ,id
					 ,ofs
					 ,count
					 );
	}

	public byte[] encode(
						 int v_id
						,long v_ofs
						,long v_count
						)
	{
		return encode(
					    (short)1
					 ,  (short)1
					 ,v_id
					 ,v_ofs
					 ,v_count
					 );
	}

	public byte[] encode(
						 short v_target_system
						,short v_target_component
						,int v_id
						,long v_ofs
						,long v_count
						)
	{
		// int[] mavLen = {1, 1, 2, 4, 4};
		// int[] javLen = {2, 2, 4, 8, 8};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putByteS(v_target_component);	// Add "target_component" parameter
		sndPacket.putShortI(v_id);	// Add "id" parameter
		sndPacket.putIntL(v_ofs);	// Add "ofs" parameter
		sndPacket.putIntL(v_count);	// Add "count" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", LOG_REQUEST_DATA_target_system"
 				+ ", LOG_REQUEST_DATA_target_component"
 				+ ", LOG_REQUEST_DATA_id"
 				+ ", LOG_REQUEST_DATA_ofs"
 				+ ", LOG_REQUEST_DATA_count"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system
 				+ ", " + target_component
 				+ ", " + id
 				+ ", " + ofs
 				+ ", " + count
				);
		return param;
	}
}
