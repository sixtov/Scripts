//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: FILE_TRANSFER_RES(112)
--------------------------------------
%%~ File transfer result
--------------------------------------
*/
public class FILE_TRANSFER_RES_class //implements Loggable
{
	public static final int msgID = 112;
	public long	 transfer_uid; 	// Unique transfer ID
	public short	 result;		 	// 0: OK, 1: not permitted, 2: bad path / file name, 3: no space left on device

	private packet rcvPacket;
	private packet sndPacket;

	public FILE_TRANSFER_RES_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public FILE_TRANSFER_RES_class(FILE_TRANSFER_RES_class o)
	{
		transfer_uid = o.transfer_uid;
		result = o.result;
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

			// int[] mavLen = {8, 1};
			// int[] javLen = {8, 2};

			transfer_uid	= rcvPacket.getLong();
			result		= rcvPacket.getShortB();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  transfer_uid
					 ,result
					 );
	}

	public byte[] encode(
						 long v_transfer_uid
						,short v_result
						)
	{
		// int[] mavLen = {8, 1};
		// int[] javLen = {8, 2};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putLong(v_transfer_uid);	// Add "transfer_uid" parameter
		sndPacket.putByteS(v_result);	// Add "result" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", FILE_TRANSFER_RES_transfer_uid"
 				+ ", FILE_TRANSFER_RES_result"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + transfer_uid
 				+ ", " + result
				);
		return param;
	}
}
