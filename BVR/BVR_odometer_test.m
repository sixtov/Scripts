%%
if (exist('u2','var')==1)
    fclose(u2);
    clear u2
end

%%
rPort = 11000;
lPort = 11001;
ip = 'localhost';
u2 = udp(ip,...
         'RemotePort', rPort, ...
         'LocalPort', lPort, ...
         'ByteOrder','bigEndian',...
         'InputBufferSize',1024,...
         'OutputBufferSize',1024);
%%
fopen(u2);

%%
scale = 1;
MaxCapacity = 7.8*[1 1 1 1];
MaxSpeed = scale*40;
MaxCurrent = scale*100;
missionDist = 16080.3;
desiredSpeed = scale*25;
tic; toc;
t0 = tic;
t1 = toc;
k = 1;
terminate = (1<0);

toff = 0;
odometer = 0;
remCapacity = MaxCapacity;
soc = 100.*remCapacity./MaxCapacity;
failureTime = 0; %(missionDist/(3*desiredSpeed))*(0.5 + rand()); % 10 to 20 minutes
count = 0;
while ~terminate
    pt = t1;
    t1 = toc;
    %disp(sprintf('time=%.2f Odo=%.0f soc=[%.1f %.1f %.1f %.1f]',t1,odometer,soc))
    d = [typecast(double(t1+toff),'uint8') ...
         typecast(single(odometer),'uint8') ...
         typecast(single(soc),'uint8')];
    fwrite(u2, d, 'uint8');
    
    rmsSOC = sqrt(mean(soc.^2));
    delta_t = t1-pt;

    tsoc = scale*15*(1-rmsSOC/100);
    throttle = 100*(desiredSpeed/MaxSpeed) + tsoc;
        
    csoc = scale*20*(1-soc./100);
    cwnoise = 1+(rand(1,2)-0.5)/5;
    current = ((throttle/100)*(MaxCurrent/2))*[cwnoise cwnoise] - csoc;
    
    curr = [mean(current([1 3])) mean(current([2 4]))];
    speed = (sum(curr)/MaxCurrent)*MaxSpeed;
    
    odometer = odometer + k*speed*delta_t;
    odometer(odometer > missionDist) = missionDist;

    if ((t1+toff) > failureTime)
        parasiticCurrent = scale*10;
    else
        parasiticCurrent = 0;
    end
    remCapacity = remCapacity - (delta_t/3600).*(current+parasiticCurrent);
    soc = 100.*remCapacity./MaxCapacity;
    soc(soc <= 0) = 0;
    
    terminate = ((odometer >= missionDist) || (all(soc< 30)));
    
    if (count == 0)
        disp(sprintf('ft=%d f=%d p=%d throttle=%.2f curr=[%.1f %.1f] soc=[%.1f %.1f %.1f %.1f] speed=%.2f',int32(failureTime-(t1+toff)),(t1+toff) > failureTime,parasiticCurrent,throttle,curr,soc,speed))
    end
    count = mod(count + 1,10);
    pause(0.10);
end

