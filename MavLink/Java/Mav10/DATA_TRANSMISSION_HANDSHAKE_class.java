//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: DATA_TRANSMISSION_HANDSHAKE(130)
--------------------------------------
--------------------------------------
*/
public class DATA_TRANSMISSION_HANDSHAKE_class //implements Loggable
{
	public static final int msgID = 130;
	public short	 type;		 	// type of requested/acknowledged data (as defined in ENUM DATA_TYPES in mavlink/include/mavlink_types.h)
	public long	 size;		 	// total data size in bytes (set on ACK only)
	public int		 width;		 	// Width of a matrix or image
	public int		 height;		 	// Height of a matrix or image
	public int		 packets;		 	// number of packets beeing sent (set on ACK only)
	public short	 payload;		 	// payload size per packet (normally 253 byte, see DATA field size in message ENCAPSULATED_DATA) (set on ACK only)
	public short	 jpg_quality;	 	// JPEG quality out of [1,100]

	private packet rcvPacket;
	private packet sndPacket;

	public DATA_TRANSMISSION_HANDSHAKE_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public DATA_TRANSMISSION_HANDSHAKE_class(DATA_TRANSMISSION_HANDSHAKE_class o)
	{
		type = o.type;
		size = o.size;
		width = o.width;
		height = o.height;
		packets = o.packets;
		payload = o.payload;
		jpg_quality = o.jpg_quality;
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

			// int[] mavLen = {1, 4, 2, 2, 2, 1, 1};
			// int[] javLen = {2, 8, 4, 4, 4, 2, 2};

			type			= rcvPacket.getShortB();
			size			= rcvPacket.getLongI();
			width		= rcvPacket.getIntS();
			height		= rcvPacket.getIntS();
			packets		= rcvPacket.getIntS();
			payload		= rcvPacket.getShortB();
			jpg_quality	= rcvPacket.getShortB();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  type
					 ,size
					 ,width
					 ,height
					 ,packets
					 ,payload
					 ,jpg_quality
					 );
	}

	public byte[] encode(
						 short v_type
						,long v_size
						,int v_width
						,int v_height
						,int v_packets
						,short v_payload
						,short v_jpg_quality
						)
	{
		// int[] mavLen = {1, 4, 2, 2, 2, 1, 1};
		// int[] javLen = {2, 8, 4, 4, 4, 2, 2};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_type);	// Add "type" parameter
		sndPacket.putIntL(v_size);	// Add "size" parameter
		sndPacket.putShortI(v_width);	// Add "width" parameter
		sndPacket.putShortI(v_height);	// Add "height" parameter
		sndPacket.putShortI(v_packets);	// Add "packets" parameter
		sndPacket.putByteS(v_payload);	// Add "payload" parameter
		sndPacket.putByteS(v_jpg_quality);	// Add "jpg_quality" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", DATA_TRANSMISSION_HANDSHAKE_type"
 				+ ", DATA_TRANSMISSION_HANDSHAKE_size"
 				+ ", DATA_TRANSMISSION_HANDSHAKE_width"
 				+ ", DATA_TRANSMISSION_HANDSHAKE_height"
 				+ ", DATA_TRANSMISSION_HANDSHAKE_packets"
 				+ ", DATA_TRANSMISSION_HANDSHAKE_payload"
 				+ ", DATA_TRANSMISSION_HANDSHAKE_jpg_quality"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + type
 				+ ", " + size
 				+ ", " + width
 				+ ", " + height
 				+ ", " + packets
 				+ ", " + payload
 				+ ", " + jpg_quality
				);
		return param;
	}
}
