%%
function MavLink = MavLinkLog(dfile)
    pid = fopen(dfile);
    tline = fgets(pid);
    
    cnt = 0;
    MavLink.Analog = struct();
    MavLink.RC     = struct();
    
    while (~isempty(tline))
        idx = strfind(tline,'__mavlink');
        if (~isempty(idx))
            cnt = cnt + 1;
            pre = tline(1:idx-1);
            [mavMessage tline] = strtok(tline(idx:end));
            switch(mavMessage)
                case '__mavlink_analog_channels_t'
                    disp(sprintf('%d %s%s',cnt,pre,mavMessage))
                    MavLink.Analog = processTokens(MavLink.Analog,tline);
                case '__mavlink_rc_channels_scaled_t'
                    disp(sprintf('%d %s%s',cnt,pre,mavMessage))
                    MavLink.RC = processTokens(MavLink.RC,tline);
                otherwise
                    cnt = cnt - 1;
                    %disp(strcat(mavMessage,' not Implemented'))
            end
            tline = fgets(pid);
        else
            tline = [];
        end
    end
    disp('Done Processing')
    fclose(pid);
    disp('Saving Data')
    save(sprintf('%s_mavLink.mat',dfile(1:end-4)),'MavLink');
    disp('Data Saved. Finished!')
return

function S = processTokens(S,list)
    while ~isempty(list)
        [myTok list] = strtok(list,[{'='} {' '} {':'}]);
        [myVal list] = strtok(list,[{'='} {' '} {':'}]);
        newval = cell2mat(textscan(myVal,'%f'));
        if (isfield(S,myTok))
            S.(myTok) = [S.(myTok); newval];
        else
            S.(myTok) = newval;
        end
    end
return
