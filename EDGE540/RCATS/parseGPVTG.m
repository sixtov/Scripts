%function lGPS = parseGPVTG(tline,lGPS)
function lGPS = parseGPVTG(tline)
    % $GPVTG
    % Track Made Good and Ground Speed. 
    % 
    % eg1. $GPVTG,360.0,T,348.7,M,000.0,N,000.0,K*43
    % eg2. $GPVTG,054.7,T,034.4,M,005.5,N,010.2,K*41
    % 
    %            054.7,T      True course made good over ground, degrees
    %            034.4,M      Magnetic course made good over ground, degrees
    %            005.5,N      Ground speed, N=Knots
    %            010.2,K      Ground speed, K=Kilometers per hour
    % 
    % eg3. for NMEA 0183 version 3.00 active the Mode indicator field
    %      is added at the end
    %      $GPVTG,054.7,T,034.4,M,005.5,N,010.2,K,A*53
    %            A            Mode indicator (A=Autonomous, D=Differential,
    %                         E=Estimated, N=Data not valid)

    lGPS = blankGPVTG();
    gpvtg = sscanf(tline,'$GPVTG,%f,%c,%f,%c,%f,%c,%f,%c,%c*%x')';
    if (length(gpvtg)==10)
        lGPS.trueCourse   = gpvtg(1);
        lGPS.trueCourseL  = char(gpvtg(2));
        lGPS.magCourse    = gpvtg(3);
        lGPS.magCourseL   = char(gpvtg(4));
        lGPS.gSpeedKnots  = gpvtg(5);
        lGPS.gSpeedKnotsU = char(gpvtg(6));
        lGPS.gSpeedKPH    = gpvtg(7);
        lGPS.gSpeedKPHU   = char(gpvtg(8));
        lGPS.mode         = char(gpvtg(9));
        lGPS.checkSum2    = gpvtg(10);
    end
return

function GPS = blankGPVTG()
    % $GPVTG Data
    GPS.trueCourse   =   0;
    GPS.trueCourseL  = 'T';
    GPS.magCourse    =   0;
    GPS.magCourseL   = 'M';
    GPS.gSpeedKnots  =   0;
    GPS.gSpeedKnotsU = 'N';
    GPS.gSpeedKPH    =   0;
    GPS.gSpeedKPHU   = 'K';
    GPS.mode         = 'N';
    GPS.checkSum2    =   0;
return
