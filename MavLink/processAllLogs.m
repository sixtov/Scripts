%%
function processAllLogs()
tlog = recursive_dir('.tlog');
N = length(tlog);
for i=1:N
    rfile = sprintf('%s_APM.mat',tlog{i}(1:end-5));
    mfile = dir(rfile);
    if (isempty(mfile))
        status = MavLinkBinLog(tlog{i});
    else
        disp(sprintf('Processed: "%s"',rfile))
        status = 1;
    end
    if (status)
        genGPXFile(rfile);
    end
end
return
