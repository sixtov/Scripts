//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: FILE_TRANSFER_START(110)
--------------------------------------
%%~ Begin file transfer
--------------------------------------
*/
public class FILE_TRANSFER_START_class //implements Loggable
{
	public static final int msgID = 110;
	public long	 transfer_uid; 	// Unique transfer ID
	public byte[]	 dest_path = new byte[240];		// Destination path
	public short	 direction;	 	// Transfer direction: 0: from requester, 1: to requester
	public long	 file_size;	 	// File size in bytes
	public short	 flags;		 	// RESERVED

	private packet rcvPacket;
	private packet sndPacket;

	public FILE_TRANSFER_START_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public FILE_TRANSFER_START_class(FILE_TRANSFER_START_class o)
	{
		transfer_uid = o.transfer_uid;
		dest_path = o.dest_path;
		direction = o.direction;
		file_size = o.file_size;
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

			// int[] mavLen = {8, 1, 1, 4, 1};
			// int[] javLen = {8, 240, 2, 8, 2};

			transfer_uid	= rcvPacket.getLong();
			rcvPacket.getByte(dest_path, 0, 240);
			direction	= rcvPacket.getShortB();
			file_size	= rcvPacket.getLongI();
			flags		= rcvPacket.getShortB();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  transfer_uid
					 ,dest_path
					 ,direction
					 ,file_size
					 ,flags
					 );
	}

	public byte[] encode(
						 long v_transfer_uid
						,byte[] v_dest_path
						,short v_direction
						,long v_file_size
						,short v_flags
						)
	{
		// int[] mavLen = {8, 1, 1, 4, 1};
		// int[] javLen = {8, 240, 2, 8, 2};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putLong(v_transfer_uid);	// Add "transfer_uid" parameter
		sndPacket.putByte(v_dest_path,0,240);	// Add "dest_path" parameter
		sndPacket.putByteS(v_direction);	// Add "direction" parameter
		sndPacket.putIntL(v_file_size);	// Add "file_size" parameter
		sndPacket.putByteS(v_flags);	// Add "flags" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", FILE_TRANSFER_START_transfer_uid"
 				+ ", FILE_TRANSFER_START_dest_path"
 				+ ", FILE_TRANSFER_START_direction"
 				+ ", FILE_TRANSFER_START_file_size"
 				+ ", FILE_TRANSFER_START_flags"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + transfer_uid
 				+ ", " + dest_path
 				+ ", " + direction
 				+ ", " + file_size
 				+ ", " + flags
				);
		return param;
	}
}
