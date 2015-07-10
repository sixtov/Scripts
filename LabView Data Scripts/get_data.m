function d = get_data(DATA,varargin)
    disp('Please use getPc4Data(dCase, varargin)')
return
    %% Process argument list
    if (nargin == 2) 
        switch(varargin{1})
            case 'plot'
                plotFlag = 1;
            otherwise
                plotFlag = 0;
        end
    else
        plotFlag = 0;
        if nargin > 2
            disp('The following extra arguments are not implemented!')
            for i=2:nargin-1
                disp(varargin{i})
            end
            return;
        end
    end
    
    %% Process Data
    d.time = DATA.time;
    d.acc_cg = DATA.CGAZ;
    d.acc_ob = DATA.CANOBAZ;
    d.acc_ib = DATA.CANIBAZ;
    d.acc_ct = DATA.CANCTRAZ;
    d.strain_aft = 1e6*DATA.AFTSTRB;
    d.strain_fwd = 1e6*DATA.FSTRB;
    
    idx = find(d.time>0.5);
    d.time = d.time(idx);
    d.acc_cg = d.acc_cg(idx);
    d.acc_ob = d.acc_ob(idx);
    d.acc_ib = d.acc_ib(idx);
    d.acc_ct = d.acc_ct(idx);
    d.strain_aft = d.strain_aft(idx);
    d.strain_fwd = d.strain_fwd(idx);
    
    [b a] = butter(4,0.2);
    
    d.acc_cg = filtfilt(b,a,d.acc_cg);
    d.acc_ob = filtfilt(b,a,d.acc_ob);
    d.acc_ib = filtfilt(b,a,d.acc_ib);
    d.acc_ct = filtfilt(b,a,d.acc_ct);
    d.strain_aft = filtfilt(b,a,d.strain_aft);
    d.strain_fwd = filtfilt(b,a,d.strain_fwd);
    
    d.time = decimate(d.time,5);
    d.acc_cg = decimate(d.acc_cg,5);
    d.acc_ob = decimate(d.acc_ob,5);
    d.acc_ib = decimate(d.acc_ib,5);
    d.acc_ct = decimate(d.acc_ct,5);
    d.strain_aft = decimate(d.strain_aft,5);
    d.strain_fwd = decimate(d.strain_fwd,5);
    
    d.acc_cg = d.acc_cg - mean(d.acc_cg);
    d.acc_ob = d.acc_ob - mean(d.acc_ob);
    d.acc_ib = d.acc_ib - mean(d.acc_ib);
    d.acc_ct = d.acc_ct - mean(d.acc_ct);
    d.strain_aft = d.strain_aft - mean(d.strain_aft);
    d.strain_fwd = d.strain_fwd - mean(d.strain_fwd);
    
    if plotFlag
        slvFigure('Input Data');
            
            subplot(2,1,1)
            hold off
            plot(d.time,d.acc_ob,'r');
            hold on
            plot(d.time,d.acc_ct,'c');
            plot(d.time,d.acc_ib,'g');
            plot(d.time,d.acc_cg,'b');
            legend([{'OutBoard Acc'} {'Center Acc'} {'InBoard Acc'} {'CG Acc'}],'Location','Best')
        
            subplot(2,1,2)
            hold off
            plot(d.time,d.strain_aft,'b');
            hold on
            plot(d.time,d.strain_fwd,'r');
            legend([{'Aft Strain'} {'Forward Strain'}],'Location','Best')
    end
return
