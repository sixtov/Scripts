%%
function vtitle(varargin)
    %title(vs(varargin{1}),'FontWeight','bold','FontSize',18,varargin{2:end});
    ttext = validString(varargin{1});
    title(ttext,'FontWeight','bold','FontSize',10,varargin{2:end});
return

