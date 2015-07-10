function mavFlights = findMavLinkFlights()
    mavFlights = findMavLink();
return

function d = findMavLink()
global prefix;
global level;

a = '.mat';
b = 'MavLink';
d = [];

if (isempty(level))
    level = 0;
end
ld = dir;
pDir = prefix;
if (~isempty(ld))
    N = length(ld);
    for i=1:N
        %disp(ld(i).name)
        if (strcmp(ld(i).name,'.') || strcmp(ld(i).name,'..')), continue; end
        if (ld(i).isdir)
            if (isempty(prefix))
                prefix = strcat(prefix,ld(i).name);
            else
                prefix = strcat(prefix,'\',ld(i).name);
            end
            cd(ld(i).name)
            level = level+1;
            d = [d; findMavLink()];
            cd('..')
            prefix = pDir;
        else
            if (strfind(ld(i).name,a))
                nfile = sprintf('%s\\%s',prefix,ld(i).name);
                warning('off','MATLAB:load:cannotInstantiateLoadedVariable');
                load(nfile);
                warning('on' ,'MATLAB:load:cannotInstantiateLoadedVariable');  %warning query last
                if (exist(b,'var')==1)
                    disp(nfile)
                    d = [d; {nfile}];
                end
            end
        end
    end
end
if (level>0)
    level = level-1;
end
return