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
odometer = 0;
soc = 100;
while 1
    disp(sprintf('Odometer=%.0f soc = %.1f',odometer,soc))
    d = [typecast(single(odometer),'uint8') ...
         typecast(single(soc),'uint8')];
    fwrite(u2, d, 'uint8');
    odometer = odometer + 5.55; % 80Km/Hr
    soc = soc - 0.25;
    if (soc <= 0)
        soc = 100;
    end
    pause(0.25);
end

