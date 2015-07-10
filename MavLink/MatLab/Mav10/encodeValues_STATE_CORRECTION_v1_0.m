%%%%  case: 64
%%~ Corrects the systems state by adding an error correction term to the position and 
%%~ velocity, and by rotating the attitude by a correction angle.
function p = encodeValues_STATE_CORRECTION_v1_0(xErr,yErr,zErr,rollErr,pitchErr,yawErr,vxErr,vyErr,vzErr)
	S.xErr = typecast(single(xErr),'single');		% x position error
	S.yErr = typecast(single(yErr),'single');		% y position error
	S.zErr = typecast(single(zErr),'single');		% z position error
	S.rollErr = typecast(single(rollErr),'single');		% roll error (radians)
	S.pitchErr = typecast(single(pitchErr),'single');		% pitch error (radians)
	S.yawErr = typecast(single(yawErr),'single');		% yaw error (radians)
	S.vxErr = typecast(single(vxErr),'single');		% x velocity
	S.vyErr = typecast(single(vyErr),'single');		% y velocity
	S.vzErr = typecast(single(vzErr),'single');		% z velocity
	p = encode_STATE_CORRECTION_v1_0(S);
return
