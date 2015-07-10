function distance_m = GPSdistance(lat1,lon1,lat2,lon2)
    maj_const=6378137;          %Major axis constant
    min_const=6356752.3142;     %Minor axis constant
    h=334.9;                    %Elevation
    
    N = length(lat1);
    distance_m = zeros(size(lat1));
    
    for i=1:N
        % True angle determination (atan=ArcTan)
        angle1=(atan((min_const^2)/(maj_const^2)*tan(lat1(i)*pi()/180)))*180/pi();
        angle2=(atan((min_const^2)/(maj_const^2)*tan(lat2(i)*pi()/180)))*180/pi();

        % Radius calculation for the two points
        r1=(1/((cos(angle1*pi()/180))^2/maj_const^2+(sin(angle1*pi()/180))^2/min_const^2))^0.5+h;
        r2=(1/((cos(angle2*pi()/180))^2/maj_const^2+(sin(angle2*pi()/180))^2/min_const^2))^0.5+h;

        % X-Y earth coordinates
        xy1=r1*cos(angle1*pi()/180);
        xy2=r2*cos(angle2*pi()/180);
        xy3=r1*sin(angle1*pi()/180);
        xy4=r2*sin(angle2*pi()/180);

        X=((xy1-xy2)^2+(xy3-xy4)^2)^0.5;         % X coordinate
        Y=2*pi()*((((xy1+xy2)/2))/360)*(lon1(i)-lon2(i));     % Y coordinate

        distance_m(i)=((X)^2+(Y)^2)^0.5;                    % Distance Meter
    end
return