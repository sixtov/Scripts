function S = buildStruct(S,mbytes,mnames,mtypes,p)
   global datestamp
   global timestamp;
   global t0;
   oldPacketID = 85;
   newPacketID = 254;
   data = p.data;
   if ((length(mbytes)~=length(mnames)) || (length(mbytes)~=length(mtypes)) || (length(mnames)~=length(mtypes)))
        disp('ERROR: Internal array sizes do not agree');
        return
    end
    N = length(mbytes);
    a = 1;
    for i=1:N
        switch (p.packetID)
            case oldPacketID
                %disp(mtypes{i})
                val = swapbytes(typecast(data(a:a+mbytes(i)-1),mtypes{i}));
            case newPacketID
                val = typecast(data(a:a+mbytes(i)-1),mtypes{i});
        end
        val = reshape(val,1,length(val));
         a = a+mbytes(i);
        if (isfield(S,mnames{i}))
            S.(mnames{i})= [S.(mnames{i}); val]; 
        else
            S.(mnames{i}) = val;
        end
    end
%     if (p.messid == 111)
%         disp('Temporary fix in buildStruct.m, please remove');
%         S.usec(end) = uint64(1e3*double(S.usec(end)));
%     end
    switch (p.packetID)
        case oldPacketID
            timeField = 'usec';
            timeFactor = 1e6;
        case newPacketID
            timeField = 'time_boot_ms';
            timeFactor = 1e3;
%%% 
%             %%Need to figure out how to bias correctly
%             if (isfield(S,'time_usec'))
%                 timeField = 'time_usec';
%                 timeFactor = 1e6;
%             end
    end
%     if(isfield(S,timeField))
%         if(isfield(S,'time'))
%             N = length(S.(timeField));
%             ntime = double(S.(timeField)(N))/timeFactor - t0;
%             delta = ntime - timestamp;
%             if (delta<0)
%                 t0 = (timeFactor*t0 - double(S.(timeField)(N-1)))/timeFactor; 
%                 ntime = double(S.(timeField)(N))/timeFactor - t0;
% %                 if (S.(timeField)(N)~=0)
% %                     disp(sprintf('[%d] %s=%d  t0=%f',p.messid,timeField,S.(timeField)(N),t0))
% %                 end
%             end
%             timestamp = ntime;
%             S.time = [S.time; timestamp];
%         else
%             if (t0==0)
%                 t0 = double(S.(timeField))/timeFactor;
% %                 disp(sprintf('t0 = %f',t0))
%             end
%             timestamp = 0;
%             S.time = timestamp;
%         end
%     else
%         if(isfield(S,'time'))
%             S.time = [S.time; timestamp];
%         else
%             S.time = timestamp;
%         end
%     end
   
    % datenum(1970,1,1) = 719529; (Jan 1, 1970)
    % dv = datevec(719529 + double(typecast(flipud(p.date),'uint64'))/8.64e10);   % convert from microseconds to days
    offset = double(typecast(flipud(p.date),'uint64'))/1e6;
    millisec = rem(offset,1);
    seconds = floor(offset);
    dv = utc_date_vector_to_local( [1970 1 1 0 0 seconds] ); 
    dv(6) = dv(6) + millisec;
    datestamp = datestr(dv,'dd-mmm-yyyy HH:MM:SS.FFF');
    %disp(datestamp)
    
    if (isfield(S,'date'))
        S.date = [S.date; dv];
    else
        S.date = dv;
    end

    if (t0==0)
        timestamp=1;
        t0 = 3600*dv(4) + 60*dv(5) + dv(6);
    end
    t1 = 3600*dv(4) + 60*dv(5) + dv(6);
    if ((t1-t0)<timestamp)
        fprintf('date=%s t1=%f t0=%f\n',datestamp,t1,t0);
    end
    timestamp = t1-t0;
    %disp(timestamp)
    if(isfield(S,'time'))
        S.time = [S.time; timestamp];
    else
        S.time = timestamp;
    end
    
return

