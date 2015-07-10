//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: FILE_TRANSFER_DIR_LIST(111)
--------------------------------------
%%~ Get directory listing
--------------------------------------
*/
public class FILE_TRANSFER_DIR_LIST_class //implements Loggable
{
	public static final int msgID = 111;
	public long	 transfer_uid; 	// Unique transfer ID
	public byte[]	 dir_path = new byte[240];		// Directory path to list
	public short	 flags;		 	// RESERVED

	private packet rcvPacket;
	private packet sndPacket;

	public FILE_TRANSFER_DIR_LIST_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public FILE_TRANSFER_DIR_LIST_class(FILE_TRANSFER_DIR_LIST_class o)
	{
		transfer_uid = o.transfer_uid;
		dir_path = o.dir_path;
		flags = o.flags;
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

			// int[] mavLen = {8, 1, 1};
			// int[] javLen = {8, 240, 2};

			transfer_uid	= rcvPacket.getLong();
			rcvPacket.getByte(dir_path, 0, 240);
			flags		= rcvPacket.getShortB();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  transfer_uid
					 ,dir_path
					 ,flags
					 );
	}

	public byte[] encode(
						 long v_transfer_uid
						,byte[] v_dir_path
						,short v_flags
						)
	{
		// int[] mavLen = {8, 1, 1};
		// int[] javLen = {8, 240, 2};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putLong(v_transfer_uid);	// Add "transfer_uid" parameter
		sndPacket.putByte(v_dir_path,0,240);	// Add "dir_path" parameter
		sndPacket.putByteS(v_flags);	// Add "flags" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", FILE_TRANSFER_DIR_LIST_transfer_uid"
 				+ ", FILE_TRANSFER_DIR_LIST_dir_path"
 				+ ", FILE_TRANSFER_DIR_LIST_flags"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + transfer_uid
 				+ ", " + dir_path
 				+ ", " + flags
				);
		return param;
	}
}
