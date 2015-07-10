//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: SET_CAM_SHUTTER(151)
--------------------------------------
--------------------------------------
*/
public class SET_CAM_SHUTTER_class //implements Loggable
{
	public static final int msgID = 151;
	public short	 cam_no;		 	// Camera id
	public short	 cam_mode;	 	// Camera mode: 0 = auto, 1 = manual
	public short	 trigger_pin;	 	// Trigger pin, 0-3 for PtGrey FireFly
	public int		 interval;	 	// Shutter interval, in microseconds
	public int		 exposure;	 	// Exposure time, in microseconds
	public float	 gain;		 	// Camera gain

	private packet rcvPacket;
	private packet sndPacket;

	public SET_CAM_SHUTTER_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public SET_CAM_SHUTTER_class(SET_CAM_SHUTTER_class o)
	{
		cam_no = o.cam_no;
		cam_mode = o.cam_mode;
		trigger_pin = o.trigger_pin;
		interval = o.interval;
		exposure = o.exposure;
		gain = o.gain;
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

			// int[] mavLen = {1, 1, 1, 2, 2, 4};
			// int[] javLen = {2, 2, 2, 4, 4, 4};

			cam_no		= rcvPacket.getShortB();
			cam_mode		= rcvPacket.getShortB();
			trigger_pin	= rcvPacket.getShortB();
			interval		= rcvPacket.getIntS();
			exposure		= rcvPacket.getIntS();
			gain			= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  cam_no
					 ,cam_mode
					 ,trigger_pin
					 ,interval
					 ,exposure
					 ,gain
					 );
	}

	public byte[] encode(
						 short v_cam_no
						,short v_cam_mode
						,short v_trigger_pin
						,int v_interval
						,int v_exposure
						,float v_gain
						)
	{
		// int[] mavLen = {1, 1, 1, 2, 2, 4};
		// int[] javLen = {2, 2, 2, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_cam_no);	// Add "cam_no" parameter
		sndPacket.putByteS(v_cam_mode);	// Add "cam_mode" parameter
		sndPacket.putByteS(v_trigger_pin);	// Add "trigger_pin" parameter
		sndPacket.putShortI(v_interval);	// Add "interval" parameter
		sndPacket.putShortI(v_exposure);	// Add "exposure" parameter
		sndPacket.putFloat(v_gain);	// Add "gain" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", SET_CAM_SHUTTER_cam_no"
 				+ ", SET_CAM_SHUTTER_cam_mode"
 				+ ", SET_CAM_SHUTTER_trigger_pin"
 				+ ", SET_CAM_SHUTTER_interval"
 				+ ", SET_CAM_SHUTTER_exposure"
 				+ ", SET_CAM_SHUTTER_gain"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + cam_no
 				+ ", " + cam_mode
 				+ ", " + trigger_pin
 				+ ", " + interval
 				+ ", " + exposure
 				+ ", " + gain
				);
		return param;
	}
}
