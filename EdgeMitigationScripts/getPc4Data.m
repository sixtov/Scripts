function d = getPc4Data(dCase, varargin)
    decimation = 1;
    filterLimit = 0.999;
    zFlag = 0;
    for i=2:2:nargin
        switch(varargin{i-1})
            case 'filter'
                filterLimit = varargin{i};
                if filterLimit < 0, filterLimit = eps;
                elseif filterLimit>=1, filterLimit=1-eps; end
            case 'decimate'
                decimation = round(varargin{i});
            case 'zerobias'
                zFlag = 1;
            otherwise
                disp(sprintf('%s is not a valid parameter',varargin{i-1}))
        end
    end

    dCases = dir(sprintf('%s\\PC104.mat', dCase));
    if ~isempty(dCases)
        load (sprintf('%s\\PC104.mat', dCase));
    else
        d = [];
        return;
    end

    d.name = dCase;
    d.Fs = 200/decimation;

    d.time = PC104.DATA.time; 
    d.cgaz = PC104.DATA.CGAZ;
    d.ibaz = PC104.DATA.CANIBAZ;
    d.ctaz = PC104.DATA.CANCTRAZ;
    d.obaz = PC104.DATA.CANOBAZ;
    d.strn = 1e6*mean([PC104.DATA.FSTRB PC104.DATA.AFTSTRB],2);
    
    idx = find(d.time>0.1);
    
    d.time = d.time(idx); 
    d.cgaz = d.cgaz(idx);
    d.ibaz = d.ibaz(idx);
    d.ctaz = d.ctaz(idx);
    d.obaz = d.obaz(idx);
    d.strn = d.strn(idx);

    d.time = decimate(d.time,decimation);
    
    d.cgaz = preprocess_data(d.cgaz,decimation,filterLimit,zFlag);
    d.ibaz = preprocess_data(d.ibaz,decimation,filterLimit,zFlag);
    d.ctaz = preprocess_data(d.ctaz,decimation,filterLimit,zFlag);
    d.obaz = preprocess_data(d.obaz,decimation,filterLimit,zFlag);
    d.strn = preprocess_data(d.strn,decimation,filterLimit,zFlag);
    
return
