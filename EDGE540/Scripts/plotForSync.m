function plotForSync()
    file = dir('PC104.mat');
    if ~isempty(file)
        load(file.name)
    else
        PC104 = [];
    end
    
    file = dir('RCATS.mat');
    if ~isempty(file)
        load(file.name)
    else
        RCATS = [];
    end
    
    file = dir('AHRS.mat');
    if ~isempty(file)
        load(file.name)
    else
        AHRS = [];
    end
    
    if ~isempty(PC104)
        %%% First alignment attempt
        if ~isempty(PC104) && ~isempty(RCATS)
            idx = find(RCATS.DATA.sync==0,1,'last')+1;
            if isempty(idx)
                idx = 1;
            end
            jdx = find(PC104.DATA.sync>RCATS.DATA.sync(idx),1,'first');
            if isempty(jdx)
                jdx = 4;
            end
            m = (PC104.DATA.time(jdx)-PC104.DATA.time(jdx-1))/(PC104.DATA.sync(jdx)-PC104.DATA.sync(jdx-1));
            b = PC104.DATA.time(jdx)-m*PC104.DATA.sync(jdx);
            td = RCATS.DATA.sync(idx)*m+b;
            time_off = RCATS.DATA.time(idx)-td;
            disp(sprintf('RCATS sync starts at time(%d) = %f',idx,time_off))
        else
            time_off = RCATS.DATA.time(1);
            disp(sprintf('RCATS sync starts at time(%d) = %f',1,time_off))
        end
    else
        time_off = RCATS.DATA.time(1);
        disp(sprintf('RCATS sync starts at time(%d) = %f',1,time_off))
    end

    if ~isempty(PC104)
        slvFigure('Synchronize PC104 and RCATS using SYNC');
        R = 0;
        if ~isempty(PC104)
            R = 1;
        end
        if ~isempty(RCATS)
            R = R+1;
        end

        pn = 1;
        if ~isempty(PC104)
            h(pn) = subplot(R,1,pn);
            plot(PC104.DATA.time,PC104.DATA.sync)
            ylim([0 3])
            grid on
            legend('PC104.DATA.sync')
            pn = pn+1;
        end

        if ~isempty(RCATS)
            h(pn) = subplot(R,1,pn);
            plot(RCATS.DATA.time-time_off,RCATS.DATA.sync)
            ylim([0 3])
            grid on
            legend('RCATS.DATA.sync')
            pn = pn+1;
        end

        slvFigure('Synchronize PC104 and RCATS using RPM and Motor Current');
        R = 0;
        if ~isempty(PC104)
            R = 1;
        end
        if ~isempty(RCATS)
            R = R+1;
        end

        pn = 1;
        if ~isempty(PC104)
            h(pn) = subplot(R,1,pn);
            plot(PC104.DATA.time,PC104.DATA.ADC16)
            grid on
            legend('PC104.DATA.ADC16')
            pn = pn+1;
        end

        if ~isempty(RCATS)
            h(pn) = subplot(R,1,pn);
            plot(RCATS.DATA.time-time_off,RCATS.DATA.rpm)
            grid on
            legend('RCATS.DATA.rpm')
            pn = pn+1;
        end


        slvFigure('Synchronize PC104 and AHRS');
        R = 0;
        if ~isempty(PC104)
            R = 1;
        end
        if ~isempty(AHRS)
            R = R+1;
        end

        pn = 1;
        if ~isempty(PC104)
            h(pn) = subplot(R,1,pn);
            plot(PC104.DATA.time,PC104.DATA.CTRACCLZ)
            grid on
            legend('PC104.DATA.CTRACCLZ')
            pn = pn+1;
        end

        if ~isempty(AHRS)
            h(pn) = subplot(R,1,pn);
            plot(AHRS.DATA.time-time_off,AHRS.DATA.AccelZ);
            grid on
            legend('AHRS.DATA.AccelZ')
            pn = pn+1;
        end
    else
        slvFigure('Synchronize RCATS and AHRS');
        R = 0;
        if ~isempty(RCATS)
            R = 1;
        end
        if ~isempty(AHRS)
            R = R+1;
        end

        pn = 1;
        if ~isempty(RCATS)
            h(pn) = subplot(R,1,pn);
            plot(RCATS.GPS.time-time_off,RCATS.GPS.alt)
            grid on
            legend('RCATS.GPS.alt')
            pn = pn+1;
        end

        if ~isempty(AHRS)
            h(pn) = subplot(R,1,pn);
            plot(AHRS.GPS.time-time_off,AHRS.GPS.alt)
            grid on
            legend('AHRS.GPS.alt')
            pn = pn+1;
        end
    end
return
    