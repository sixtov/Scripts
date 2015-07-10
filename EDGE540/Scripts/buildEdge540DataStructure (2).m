function buildEdge540DataStructure(rcat2pc104_Offset, ahrs2pc104_Offset,toff)
    file = dir('PC104.mat');
    if ~isempty(file)
        load(file.name)
    else
        PC104 = [];
    end
    
    file = dir('RCATS.mat');
    if ~isempty(file)
        load(file.name)
        RCATS.DATA.time = RCATS.DATA.time - toff + rcat2pc104_Offset;
        RCATS.GPS.time  = RCATS.GPS.time  - toff + rcat2pc104_Offset;
    else
        RCATS = [];
    end
    
    file = dir('AHRS.mat');
    if ~isempty(file)
        load(file.name)
        AHRS.DATA.time = AHRS.DATA.time - toff + ahrs2pc104_Offset;
        AHRS.GPS.time  = AHRS.GPS.time  - toff + ahrs2pc104_Offset;
    else
        AHRS = [];
    end
    
    if ~isempty(PC104)
        EDGE.PC104.DATA = truncateStructureMembers(PC104.DATA,find(PC104.DATA.time>=0));
    else
        EDGE.PC104 = [];
    end
    if ~isempty(RCATS)
        EDGE.RCATS.DATA = truncateStructureMembers(RCATS.DATA,find(RCATS.DATA.time>=0));
        EDGE.RCATS.GPS  = truncateStructureMembers(RCATS.GPS ,find(RCATS.GPS.time >=0));
    else
        EDGE.RCATS = [];
    end
    if ~isempty(AHRS)
        EDGE.AHRS.DATA  = truncateStructureMembers(AHRS.DATA ,find(AHRS.DATA.time >=0));
        EDGE.AHRS.GPS   = truncateStructureMembers(AHRS.GPS  ,find(AHRS.GPS.time  >=0));
    else
        EDGE.AHRS = [];
    end
    save('EDGE.mat','EDGE');
    
    slvFigure('Synchronize Data Systems');
    
    C = 2;
    NP = 0;
    if ~isempty(EDGE.PC104)
        NP = 3;
    end
    if ~isempty(EDGE.RCATS)
        NP = NP+3;
    end
    if ~isempty(EDGE.AHRS)
        NP = NP+2;
    end
    R = NP/C;
    
    pn = 1;
    if ~isempty(EDGE.PC104)
        h(pn) = subplot(R,C,pn);
        plot(EDGE.PC104.DATA.time,EDGE.PC104.DATA.sync)
        ylim([0 3])
        grid on
        legend('PC104.DATA.sync')
        pn = pn+1;
    end
    if ~isempty(EDGE.PC104)
        h(pn) = subplot(R,C,pn);
        plot(EDGE.PC104.DATA.time,EDGE.PC104.DATA.ADC16)
        grid on
        legend('PC104.DATA.ADC16')
        pn = pn+1;
    end
    if ~isempty(EDGE.RCATS)
        h(pn) = subplot(R,C,pn);
        plot(EDGE.RCATS.DATA.time,EDGE.RCATS.DATA.sync)
        ylim([0 3])
        grid on
        legend('RCATS.DATA.sync')
        pn = pn+1;
    end
    if ~isempty(EDGE.RCATS)
        h(pn) = subplot(R,C,pn);
        plot(EDGE.RCATS.DATA.time,EDGE.RCATS.DATA.rpm)
        grid on
        legend('RCATS.DATA.rpm')
        pn = pn+1;
    end
    if ~isempty(AHRS)
        h(pn) = subplot(R,C,pn);
        plot(EDGE.AHRS.GPS.time,EDGE.AHRS.GPS.alt)
        grid on
        legend('AHRS.GPS.alt')
        pn = pn+1;
    end
    if ~isempty(EDGE.AHRS)
        h(pn) = subplot(R,C,pn);
        plot(EDGE.AHRS.DATA.time,EDGE.AHRS.DATA.AccelZ)
        grid on
        legend('AHRS.DATA.AccelZ')
        pn = pn+1;
    end
    if ~isempty(EDGE.RCATS)
        h(pn) = subplot(R,C,pn);
        plot(EDGE.RCATS.GPS.time,EDGE.RCATS.GPS.alt)
        grid on
        legend('RCATS.GPS.alt')
        pn = pn+1;
    end
    if ~isempty(EDGE.PC104)
        h(pn) = subplot(R,C,pn);
        plot(EDGE.PC104.DATA.time,EDGE.PC104.DATA.CTRACCLZ)
        grid on
        legend('PC104.DATA.CTRACCLZ')
        pn = pn+1;
    end
    
    linkaxes(h,'x')
return

function data = truncateStructureMembers(data,idx)
    names = fieldnames(data);
    N = length(names);
    for i=1:N
        fname = names{i};
        data.(fname) = data.(fname)(idx);
    end
return

    