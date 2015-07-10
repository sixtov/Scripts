%%
clear
dfile = dir('*.mat');
N = length(dfile);
date = zeros(N,1);
for i=1:N
    date(i) = dfile(i).datenum;
end
[date idx] = sort(date);
slvFigure('APM Load');
clf
color = [{'b'} {'r'} {'g'}];
M = 0;
S = 0;
dticks = 0;
sticks = 0;
for i=1:N
    disp(dfile(idx(i)).name);
    load(dfile(idx(i)).name);
    
    sdx = M+1;
    M = M+length(MavLink.SYS_STATUS.load);
    edx = M;
    dticks = [dticks; M];
    subplot(2,1,1)
    plot((sdx:edx),MavLink.SYS_STATUS.load,strcat(color{mod(i-1,3)+1},'.'))
    hold on
    grid on
    set(gca,'Xtick',dticks)
    
    ssx = S+1;
    S = S+length(MavLink.ATTITUDE.pitch);
    esx = S;
    sticks = [sticks; S];
    subplot(2,1,2)
    plot((ssx:esx),MavLink.ATTITUDE.pitch,strcat(color{mod(i-1,3)+1},'.'))
    hold on
    grid on
    set(gca,'Xtick',sticks)
    pause(1)
end
