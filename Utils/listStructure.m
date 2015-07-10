function listStructure(S)
    global indent
    if isempty(indent)
        indent = '...';
    else
        indent = strcat(indent,'...');
    end
    fields = fieldnames(S);
    N = length(fields);
    for i=1:N
        %text = strcat(indent,fields{i});
        text = fields{i};
        disp(text)
        if isstruct(S.(fields{i}))
            listStructure(S.(fields{i}));
        end
    end
    indent = indent(1:end-3);
    if isempty(indent)
        clear global indent;
    end
return
