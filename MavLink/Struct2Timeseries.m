%%
function [A tsc] = Struct2Timeseries(S,name)
    global dtime;
    global tsc;
    b = [];
    m = [];
    nonUnique = 0;
    %tsc = tscollection([],'name','MavLink');
    names = fieldnames(S);
    N = length(names);
    if (N==0)
        A = [];
        disp(sprintf('%s structure is empty',name));
        return;
    end
    warning('off', 'interpolation:interpolation:noextrap');
    for i=1:N
        %disp(sprintf('Processing %s',names{i}))
        dname = strcat(name,'_',names{i});
        if (isstruct(S.(names{i})))
            %disp(dname)
            A.(names{i}) = Struct2Timeseries(S.(names{i}),dname);
        else
            if (isfield(S,'h_time'))
                if (~strcmpi(names{i},'h_time'))
                    if isempty(m)
                        [b m] = unique(S.h_time);
                        if (length(S.h_time)~=length(m))
                            S.h_time = S.h_time(m);
                            nonUnique = 1;
                        end
                    end
                    if (nonUnique)
                        S.(names{i}) = S.(names{i})(m);
                    end
                    if isempty(dtime)
                        st = 0;
                        %et = max(S.h_time)-mod(max(S.h_time),10);
                        et = max([S.h_time; 1]);
                        it = 10^(floor(log10(et))-4);
    %                     if (et<1000)
    %                         it = 0.1;
    %                     else
    %                         if (et<10000)
    %                             it = 1;
    %                         else
    %                             it = 10;
    %                         end
    %                     end
                        dtime = (st:it:et)';
                    end
%                     switch(dname)
%                         case 'APM_ATTITUDE_yaw'
%                             A.(names{i}) = timeseries(180/pi*unwrap(pi/180*double(S.(names{i}))),S.h_time,'name',dname);
%                         case 'APM_GPS_RAW_hdg'
%                             A.(names{i}) = timeseries(180/pi*unwrap(pi/180*double(S.(names{i}))),S.h_time,'name',dname);
%                         case 'APM_NAV_CONTROLLER_OUTPUT_nav_bearing'
%                             A.(names{i}) = timeseries(180/pi*unwrap(pi/180*double(S.(names{i}))),S.h_time,'name',dname);
%                         case 'APM_NAV_CONTROLLER_OUTPUT_target_bearing'
%                             A.(names{i}) = timeseries(180/pi*unwrap(pi/180*double(S.(names{i}))),S.h_time,'name',dname);
%                         case 'APM_VFR_HUD_heading'
%                             A.(names{i}) = timeseries(180/pi*unwrap(pi/180*double(S.(names{i}))),S.h_time,'name',dname);
%                         otherwise
%                             A.(names{i}) = timeseries(double(S.(names{i})),S.h_time,'name',dname);
%                     end
                    A.(names{i}) = timeseries(double(S.(names{i})),S.h_time,'name',dname);
                    %A.(names{i}) = resample(A.(names{i}),dtime);
                    if (length(S.h_time)>1)
                        if isempty(tsc)
                            tsc = tscollection(resample(A.(names{i}),dtime,'zoh'),'name','MavLink');
                        else
                            tsc = addts(tsc,resample(A.(names{i}),dtime,'zoh'));
                        end
                    end
                end
            end
        end
    end
    warning('on', 'interpolation:interpolation:noextrap');
return

%%
% function A = Struct2TimeseriesS(S)
%     names = fieldnames(S);
%     N = length(names);
%     for i=1:N
%         %disp(sprintf('Processing %s',names{i}))
%         if (isstruct(S.(names{i})))
%             A.(names{i}) = Struct2Timeseries(S.(names{i}));
%         else
%             if (~strcmpi(names{i},'time'))
%                 A.(names{i}) = timeseries(double(S.(names{i})),S.time);
%             end
%         end
%     end
% return
