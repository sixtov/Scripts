%%% Call examoples:
% getSimData(dCase)
% getSimData(dCase, 'filename')
% getSimData(dCase, 'filename', [{'field1'} {'field2'}...])
% getSimData(dCase, [{'field1'} {'field2'}...])
function d = getSimData(dCase, rev, varargin)
    fname = sprintf('*sim*');
    dList = dir(sprintf('%s',dCase));
    if isempty(dList)
        disp(sprintf('%s not found in current directory.\n',dCase));
        d = [];
        return;
    end
    if ~isempty(varargin)       %(nargin > 2) && (isa(varargin{1},'char'))  )
        decimation = varargin{1};
        filterLimit = varargin{2};
    end
    flist = dir(sprintf('%s\\%s',dCase, fname));
    if isempty(flist)
        disp(sprintf('no %s found in %s.',fname, dCase));
        d = [];
        return;
    else
        nf = length(flist);
        if nf > 1
            fp = flist(1);
        else
            fp = flist;
        end
    end    
    id = load(sprintf('%s\\%s',dCase, fp.name));
    if ( ~isempty(varargin) &&  isa(varargin{1},'cell') )
        fields = varargin{1};
    elseif ( length(varargin)>1 && isa(varargin{2},'cell') )
        fields = varargin{2};
    else  % take default fields
        fields = [{'TimeStamp'} {'nzbody'} {'lon_stk'} {'ELLOB'} ];
    end
    nf = length(fields);
    for i = 1:nf
        if (isfield(id,fields{i}) )
            if (rev == 0) %old rev
                d.(fields{i}) = id.(fields{i}).signals.values(:);
            else
                d.(fields{i}) = id.(fields{i})(:);
            end
        else
            disp(sprintf('%s not found in %s Sim data.',fields{i}, dCase))
        end
    end
    d.TimeStamp = decimate(d.TimeStamp,decimation); 
    d.nzbody  = preprocess_data(d.nzbody,  decimation, filterLimit);
    d.lon_stk = preprocess_data(d.lon_stk, decimation, filterLimit);
    d.ELLOB   = preprocess_data(d.ELLOB,   decimation, filterLimit);

    idx = find(d.TimeStamp>0.1);
    d.TimeStamp = d.TimeStamp(idx); 
    d.nzbody    = d.nzbody(idx);
    d.lon_stk   = d.lon_stk(idx);
    d.ELLOB     = d.ELLOB(idx);
return
