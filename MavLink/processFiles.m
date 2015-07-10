%% Process File(s)
clear
dfile = dir('*.tlog');
N = length(dfile);
bytes = zeros(N,1);
for i=1:N
    bytes(i) = dfile(i).bytes;
end
[s, idx] = sort(bytes); 
%idx = 1:N;

status = 0;

for i=1:N
    rfile = sprintf('%s_APM.mat',dfile(idx(i)).name(1:end-5));
    efile = dir(rfile);
    if isempty(efile)
        fprintf('[%d/%d] %s\n',i,N,rfile);
        status = MavLinkBinLog(dfile(idx(i)).name);
        %pause(0.1);
    else
        status = 1;
        fprintf('[%d/%d] %s already exist\n',i,N,rfile);
    end
    if (status)
        genGPXFile(rfile);
    end
end
fprintf('processFiles() done!!!\n');

