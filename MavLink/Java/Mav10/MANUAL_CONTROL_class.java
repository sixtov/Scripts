//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: MANUAL_CONTROL(69)
--------------------------------------
%%~ This message provides an API for manually controlling the vehicle using standard 
%%~ joystick axes nomenclature, along with a joystick-like input device. Unused axes 
%%~ can be disabled an buttons are also transmit as boolean values of their 
--------------------------------------
*/
public class MANUAL_CONTROL_class //implements Loggable
{
	public static final int msgID = 69;
	public short	 target;	 	// The system to be controlled.
	public short	 x;		 	// X-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to forward(1000)-backward(-1000) movement on a joystick and the pitch of a vehicle.
	public short	 y;		 	// Y-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to left(-1000)-right(1000) movement on a joystick and the roll of a vehicle.
	public short	 z;		 	// Z-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a separate slider movement with maximum being 1000 and minimum being -1000 on a joystick and the thrust of a vehicle.
	public short	 r;		 	// R-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a twisting of the joystick, with counter-clockwise being 1000 and clockwise being -1000, and the yaw of a vehicle.
	public int		 buttons;	 	// A bitfield corresponding to the joystick buttons' current state, 1 for pressed, 0 for released. The lowest bit corresponds to Button 1.

	private packet rcvPacket;
	private packet sndPacket;

	public MANUAL_CONTROL_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public MANUAL_CONTROL_class(MANUAL_CONTROL_class o)
	{
		target = o.target;
		x = o.x;
		y = o.y;
		z = o.z;
		r = o.r;
		buttons = o.buttons;
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

			// int[] mavLen = {1, 2, 2, 2, 2, 2};
			// int[] javLen = {2, 2, 2, 2, 2, 4};

			target	= rcvPacket.getShortB();
			x		= rcvPacket.getShort();
			y		= rcvPacket.getShort();
			z		= rcvPacket.getShort();
			r		= rcvPacket.getShort();
			buttons	= rcvPacket.getIntS();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  target
					 ,x
					 ,y
					 ,z
					 ,r
					 ,buttons
					 );
	}

	public byte[] encode(
						 short v_target
						,short v_x
						,short v_y
						,short v_z
						,short v_r
						,int v_buttons
						)
	{
		// int[] mavLen = {1, 2, 2, 2, 2, 2};
		// int[] javLen = {2, 2, 2, 2, 2, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target);	// Add "target" parameter
		sndPacket.putShort(v_x);	// Add "x" parameter
		sndPacket.putShort(v_y);	// Add "y" parameter
		sndPacket.putShort(v_z);	// Add "z" parameter
		sndPacket.putShort(v_r);	// Add "r" parameter
		sndPacket.putShortI(v_buttons);	// Add "buttons" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", MANUAL_CONTROL_target"
 				+ ", MANUAL_CONTROL_x"
 				+ ", MANUAL_CONTROL_y"
 				+ ", MANUAL_CONTROL_z"
 				+ ", MANUAL_CONTROL_r"
 				+ ", MANUAL_CONTROL_buttons"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target
 				+ ", " + x
 				+ ", " + y
 				+ ", " + z
 				+ ", " + r
 				+ ", " + buttons
				);
		return param;
	}
}
