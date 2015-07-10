function verifyMavLink(veh)
    if(~exist('veh','var'))
        veh = [];
    end
    dfile = dir('*mavLink.mat');
    N = length(dfile);
    for i=1:N
        verify(dfile(i).name,veh);
    end
return

function verify(dfile,veh)
    load(dfile);
    if(~isfield(MavLink,'Vehicle'))
        MavLink.Vehicle = 0;
        if (~isempty(veh)&&isnum(veh))
            MavLink.Vehicle = veh;
        else
            idx = regexpi(dfile,'R[0-9]_');
            if (~isempty(idx))
                MavLink.Vehicle = sscanf(dfile(idx(1)+1),'%d');
            else
                MavLink.Vehicle = input('Enter Vehicle Number, e.g. 1 for R1, 2 for R2 or 3 for R3');
            end
        end
    end
    
    MavLink = verifyEU(MavLink,MavLink.Vehicle);
    
return