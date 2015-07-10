//MavLink 0.9

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: MOUNT_CONTROL(157)
--------------------------------------
%%~ Message to control a camera mount, directional antenna, etc.
--------------------------------------
*/
public class MOUNT_CONTROL_class //implements Loggable
{
	public static final int msgID = 157;
	public short	 target_system;	 	// System ID
	public short	 target_component; 	// Component ID
	public int		 input_a;			 	// pitch(deg*100) or lat, depending on mount mode
	public int		 input_b;			 	// roll(deg*100) or lon depending on mount mode
	public int		 input_c;			 	// yaw(deg*100) or alt (in cm) depending on mount mode
	public short	 save_position;	 	// if "1" it will save current trimmed position on EEPROM (just valid for NEUTRAL and LANDING)

	private packet rcvPacket;
	private packet sndPacket;

	public MOUNT_CONTROL_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
		target_component = 1;
	}

	public MOUNT_CONTROL_class(MOUNT_CONTROL_class o)
	{
		target_system = o.target_system;
		target_component = o.target_component;
		input_a = o.input_a;
		input_b = o.input_b;
		input_c = o.input_c;
		save_position = o.save_position;
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

			// int[] mavLen = {1, 1, 4, 4, 4, 1};
			// int[] javLen = {2, 2, 4, 4, 4, 2};

			target_system	= rcvPacket.getShortB();
			target_component	= rcvPacket.getShortB();
			input_a			= rcvPacket.getInt();
			input_b			= rcvPacket.getInt();
			input_c			= rcvPacket.getInt();
			save_position	= rcvPacket.getShortB();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  (short)1
					 ,(short)1
					 ,input_a
					 ,input_b
					 ,input_c
					 ,save_position
					 );
	}

	public byte[] encode(
						 int v_input_a
						,int v_input_b
						,int v_input_c
						,short v_save_position
						)
	{
		return encode(
					    (short)1
					 ,  (short)1
					 ,v_input_a
					 ,v_input_b
					 ,v_input_c
					 ,v_save_position
					 );
	}

	public byte[] encode(
						 short v_target_system
						,short v_target_component
						,int v_input_a
						,int v_input_b
						,int v_input_c
						,short v_save_position
						)
	{
		// int[] mavLen = {1, 1, 4, 4, 4, 1};
		// int[] javLen = {2, 2, 4, 4, 4, 2};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putByteS(v_target_component);	// Add "target_component" parameter
		sndPacket.putInt(v_input_a);	// Add "input_a" parameter
		sndPacket.putInt(v_input_b);	// Add "input_b" parameter
		sndPacket.putInt(v_input_c);	// Add "input_c" parameter
		sndPacket.putByteS(v_save_position);	// Add "save_position" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", MOUNT_CONTROL_target_system"
 				+ ", MOUNT_CONTROL_target_component"
 				+ ", MOUNT_CONTROL_input_a"
 				+ ", MOUNT_CONTROL_input_b"
 				+ ", MOUNT_CONTROL_input_c"
 				+ ", MOUNT_CONTROL_save_position"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system
 				+ ", " + target_component
 				+ ", " + input_a
 				+ ", " + input_b
 				+ ", " + input_c
 				+ ", " + save_position
				);
		return param;
	}
}
