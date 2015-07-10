function S = buildStruct(mbytes,mnames,mtypes,p)
   global pdate;
   global datestamp
   global timestamp;
   global t0;
   
   v0_9 = 85;
   v1_0 = 254;
   
   head   = p(1);
   len    = p(2);
   count  = p(3);
   sysid  = p(4);
   id     = p(5);
   messid = p(6);
   data = p(7:end-2);
   
   if ((length(mbytes)~=length(mnames)) || (length(mbytes)~=length(mtypes)) || (length(mnames)~=length(mtypes)))
        disp('ERROR: Internal array sizes do not agree');
        return
    end
    N = length(mbytes);
    a = 1;
    for i=1:N
        switch (head)
            case v0_9
                %disp(mtypes{i})
                val = swapbytes(typecast(data(a:a+mbytes(i)-1),mtypes{i}));
            case v1_0
                val = typecast(data(a:a+mbytes(i)-1),mtypes{i});
        end
        val = reshape(val,1,length(val));
        S.(mnames{i}) = val;
        a = a + mbytes(i);
    end
    
    % datenum(1970,1,1) = 719529; (Jan 1, 1970)
    % dv = datevec(719529 + double(typecast(flipud(p.date),'uint64'))/8.64e10);   % convert from microseconds to days
    offset = double(typecast(flipud(pdate),'uint64'))/1e6;
    millisec = rem(offset,1);
    seconds = floor(offset);
    dv = utc_date_vector_to_local( [1970 1 1 0 0 seconds] ); 
    dv(6) = dv(6) + millisec;
    datestamp = datestr(dv,'dd-mmm-yyyy HH:MM:SS.FFF');
    %disp(datestamp)

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
    
    S.h_head = uint8(head);
    S.h_len = uint8(len);
    S.h_count = uint8(count);
    S.h_sysid = uint8(sysid);
    S.h_id = uint8(id);
    S.h_messid = uint8(messid);
    S.h_date = dv;
    S.h_time = timestamp;
    
return

