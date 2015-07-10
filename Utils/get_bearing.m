function head = get_bearing(lat1,lon1,lat2,lon2)
    scaleLongUp = 1;
    off_x = lon2 - lon1;
	off_y = (lat2 - lat1) * scaleLongUp;
	head  =	90 + atan2(-off_y, off_x) * 57.2957795;
	if (head < 0), head = head + 360; end
return
