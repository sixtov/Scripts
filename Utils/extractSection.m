function data = extractSection(data,idrange)
    if isempty(idrange)
        return;
    end
    names = fieldnames(data);
    N = length(names);
    for i=1:N
        fname = names{i};
        if isstruct(data.(fname))
            data.(fname) = extractSection(data.(fname),idrange);
        else
            [row col] = size(data.(fname));
            if min(row,col)==1  %if isnumeric(data.(fname))
                [row col] = size(data.(fname));
                if (max(row,col) >= max(idrange))
                    %disp(sprintf('%s truncated (%d %d)',fname,min(idrange),max(idrange)))
                    if row>col
                        if col > 1
                            for j=1:col
                                junk(:,j) = data.(fname)(idrange,j);
                            end
                            data.(fname) = junk;
                        else
                            data.(fname) = data.(fname)(idrange);
                        end
                    else % col>row
                        if row > 1
                            for j=1:row
                                junk(j,:) = data.(fname)(j,idrange);
                            end
                            data.(fname) = junk;
                        else
                            data.(fname) = data.(fname)(idrange);
                        end
                    end
                end
            end
        end
    end
return
