%%
function simpleSOC
    clear
    pfiles = recursive_dir('.mat');
    N = length(pfiles);
    for i=1:N
        disp(sprintf('Processing "%s"',pfiles{i}))
        load(pfiles{i});
        if (isfield(PC104.AD1,'URA40V'))
            bAD = PC104.AD1;
        end
        if (isfield(PC104.AD2,'URA40V'))
            bAD = PC104.AD2;
        end

        if (exist('bAD','var')~=1), continue; end

        if (isfield(PC104.AD1,'RPM'))
            rAD = PC104.AD1;
        end
        if (isfield(PC104.AD2,'RPM'))
            rAD = PC104.AD2;
        end

        P.rpm_ts    = timeseries(rAD.RPM , rAD.time);
    %     P.llf20v_ts = timeseries(smooth(bAD.time,bAD.LLF20V,1),bAD.time);
    %     P.ula20v_ts = timeseries(smooth(bAD.time,bAD.ULA20V,1),bAD.time);
    %     P.lrf40v_ts = timeseries(smooth(bAD.time,bAD.LRF40V,1)-P.llf20v_ts.data,bAD.time);
    %     P.ura40v_ts = timeseries(smooth(bAD.time,bAD.URA40V,1)-P.ula20v_ts.data,bAD.time);
    % 
    %     P.llf20c_ts = timeseries(smooth(bAD.time,bAD.LLF20C,1),bAD.time);
    %     P.ula20c_ts = timeseries(smooth(bAD.time,bAD.ULA20C,1),bAD.time);
    %     P.lrf40c_ts = timeseries(smooth(bAD.time,bAD.LRF40C,1),bAD.time);
    %     P.ura40c_ts = timeseries(smooth(bAD.time,bAD.URA40C,1),bAD.time);
        P.llf20v_ts = timeseries(bAD.LLF20V           ,bAD.time);
        P.ula20v_ts = timeseries(bAD.ULA20V           ,bAD.time);
        P.lrf40v_ts = timeseries(bAD.LRF40V-bAD.LLF20V,bAD.time);
        P.ura40v_ts = timeseries(bAD.URA40V-bAD.ULA20V,bAD.time);

        P.llf20c_ts = timeseries(bAD.LLF20C-mean(bAD.LLF20C(bAD.time<100)),bAD.time);
        P.ula20c_ts = timeseries(bAD.ULA20C-mean(bAD.ULA20C(bAD.time<100)),bAD.time);
        P.lrf40c_ts = timeseries(bAD.LRF40C-mean(bAD.LRF40C(bAD.time<100)),bAD.time);
        P.ura40c_ts = timeseries(bAD.URA40C-mean(bAD.URA40C(bAD.time<100)),bAD.time);

        P = BatteryRUL(P,pfiles{i});
        saveas(gcf, strcat(pfiles{i}(1:end-3),'fig'));
        close(gcf)
    end
return
