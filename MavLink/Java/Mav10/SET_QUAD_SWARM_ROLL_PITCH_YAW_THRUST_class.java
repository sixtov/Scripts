//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST(61)
--------------------------------------
%%~ Setpoint for up to four quadrotors in a group / wing
--------------------------------------
*/
public class SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST_class //implements Loggable
{
	public static final int msgID = 61;
	public short	 group;	 	// ID of the quadrotor group (0 - 255, up to 256 groups supported)
	public short	 mode;	 	// ID of the flight mode (0 - 255, up to 256 modes supported)
	public short[]	 roll = new short[8];		// Desired roll angle in radians +-PI (+-INT16_MAX)
	public short[]	 pitch = new short[8];		// Desired pitch angle in radians +-PI (+-INT16_MAX)
	public short[]	 yaw = new short[8];			// Desired yaw angle in radians, scaled to int16 +-PI (+-INT16_MAX)
	public int[]		 thrust = new int[16];		// Collective thrust, scaled to uint16 (0..UINT16_MAX)

	private packet rcvPacket;
	private packet sndPacket;

	public SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST_class(SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST_class o)
	{
		group = o.group;
		mode = o.mode;
		roll = o.roll;
		pitch = o.pitch;
		yaw = o.yaw;
		thrust = o.thrust;
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

			// int[] mavLen = {1, 1, 2, 2, 2, 2};
			// int[] javLen = {2, 2, 8, 8, 8, 16};

			group	= rcvPacket.getShortB();
			mode		= rcvPacket.getShortB();
			rcvPacket.getByte(roll, 0, 8);
			rcvPacket.getByte(pitch, 0, 8);
			rcvPacket.getByte(yaw, 0, 8);
//	ERROR	Parsing 'thrust' array of 'int' from 'uint16_t[4]'
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  group
					 ,mode
					 ,roll
					 ,pitch
					 ,yaw
					 ,thrust
					 );
	}

	public byte[] encode(
						 short v_group
						,short v_mode
						,short[] v_roll
						,short[] v_pitch
						,short[] v_yaw
						,int[] v_thrust
						)
	{
		// int[] mavLen = {1, 1, 2, 2, 2, 2};
		// int[] javLen = {2, 2, 8, 8, 8, 16};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_group);	// Add "group" parameter
		sndPacket.putByteS(v_mode);	// Add "mode" parameter
		sndPacket.putByte(v_roll,0,8);	// Add "roll" parameter
		sndPacket.putByte(v_pitch,0,8);	// Add "pitch" parameter
		sndPacket.putByte(v_yaw,0,8);	// Add "yaw" parameter
//	ERROR	Encoding 'thrust' array of 'int' from 'uint16_t[4]'
	// Add "thrust" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST_group"
 				+ ", SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST_mode"
 				+ ", SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST_roll"
 				+ ", SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST_pitch"
 				+ ", SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST_yaw"
 				+ ", SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST_thrust"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + group
 				+ ", " + mode
 				+ ", " + roll
 				+ ", " + pitch
 				+ ", " + yaw
 				+ ", " + thrust
				);
		return param;
	}
}
