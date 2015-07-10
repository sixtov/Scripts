function data = mergeStruct(s1,s2)
    names = fieldnames(s1);
    N = length(names);
    for i=1:N
        fname = names{i};
        if isstruct(s1.(fname))
            data.(fname) = mergeStruct(s1.(fname),s2.(fname));
        else
            if isnumeric(s1.(fname))
                data.(fname) = [s1.(fname); s2.(fname)];
            else
                if iscellstr(s1.(fname))
                    a1 = s1.(fname);
                else
                    a1 = {s1.(fname)};
                end
                if iscellstr(s2.(fname))
                    a2 = s2.(fname);
                else
                    a2 = {s2.(fname)};
                end
                data.(fname) = [a1; a2];
                %data.(fname) = [{s1.(fname)}; {s2.(fname)}];
            end
%             [row col] = size(s1.(fname));
%             if min(row,col)==1  %if isnumeric(data.(fname))
%                 [row col] = size(s1.(fname));
%                 if (max(row,col) >= max(idrange))
%                     %disp(sprintf('%s truncated (%d %d)',fname,min(idrange),max(idrange)))
%                     if row>col
%                         if col > 1
%                             for j=1:col
%                                 junk(:,j) = data.(fname)(idrange,j);
%                             end
%                             data.(fname) = junk;
%                         else
%                             data.(fname) = data.(fname)(idrange);
%                         end
%                     else % col>row
%                         if row > 1
%                             for j=1:row
%                                 junk(j,:) = data.(fname)(j,idrange);
%                             end
%                             data.(fname) = junk;
%                         else
%                             data.(fname) = data.(fname)(idrange);
%                         end
%                     end
%                 end
%             end
        end
    end
return
