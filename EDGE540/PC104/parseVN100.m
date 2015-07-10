function VN100 = parseVN100(data)
    [N M] = size(data);
    vidx = [];
    top = [];
    bot = [];
    
%     pidx = 0;
%     dArray = data(:,1:M-1)';
%     dArray = dArray(:);
% %     cArray = char(dArray);
% %     tf = isstrprop(cArray, 'print');
% %     cArray = cArray(tf);
% %     fid = fopen('VN100.txt','w');
% %     fprintf(fid,'%c',cArray);
% %     fclose(fid);
%     
%     row = 0;
%     while ~isempty(dArray)
%         [myTok dArray sidx] = getLineTokens(dArray,',*','$',char(13));
%         sidx = sidx + pidx;
%         pidx = sidx;
%         cnt = round(sidx/(M-1));
%         vidx = [vidx; cnt];
%         K = length(myTok);
%         if K
%             switch (myTok{1})
%                 case '$VNYPR'
%                     row = row +1;
%                     lyaw = NaN;
%                     lpitch = NaN;
%                     lroll = NaN;
%                     %'#$VNYPR,-096.72,+007.34,-009.81*50'
%                     for i=2:K
%                         switch (i)
%                             %top = [top; sscanf(char(data(i, 2:idx(1)-1)),'$VNYPR,%f,%f,%f*%d')'];
%                             case 2
%                                 lyaw = sscanf(myTok{i},'%f');
%                             case 3
%                                 lpitch = sscanf(myTok{i},'%f');
%                             case 4
%                                 lroll = sscanf(myTok{i},'%f');
%                         end
%                     end
%                     yaw(row,1) = lyaw;
%                     pitch(row,1) = lpitch;
%                     roll(row,1) = lroll;
%                 case '$VNQMR'
%                     lquat    = [NaN NaN NaN NaN];
%                     lmagv    = [NaN NaN NaN];
%                     laccv    = [NaN NaN NaN];
%                     langrate = [NaN NaN NaN];
%                     %'$VNQMR,+0.021375,-0.049923,+0.797361,-0.601055,-0.2354,+0.8029,+1.8875,+00.795,-00.412,-09.709,-00.0201,-00.0055,-00.0149*76'
%                     for i=2:K
%                         switch (i)
%                             %bot = [bot; sscanf(char(data(i,52:idx(2)-1)),'$VNQMR,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f*%d')'];
%                             case 2
%                                 lquat(1)    = sscanf(myTok{i},'%f');
%                             case 3
%                                 lquat(2)    = sscanf(myTok{i},'%f');
%                             case 4
%                                 lquat(3)    = sscanf(myTok{i},'%f');
%                             case 5
%                                 lquat(4)    = sscanf(myTok{i},'%f');
%                             case 6
%                                 lmagv(1)    = sscanf(myTok{i},'%f');
%                             case 7
%                                 lmagv(2)    = sscanf(myTok{i},'%f');
%                             case 8
%                                 lmagv(3)    = sscanf(myTok{i},'%f');
%                             case 9
%                                 laccv(1)    = sscanf(myTok{i},'%f');
%                             case 10
%                                 laccv(2)    = sscanf(myTok{i},'%f');
%                             case 11
%                                 laccv(3)    = sscanf(myTok{i},'%f');
%                             case 12
%                                 langrate(1) = sscanf(myTok{i},'%f');
%                             case 13
%                                 langrate(2) = sscanf(myTok{i},'%f');
%                             case 14
%                                 langrate(3) = sscanf(myTok{i},'%f');
%                         end
%                     end
%                     quat(row,:) = lquat;
%                     magv(row,:) = lmagv;
%                     accv(row,:) = laccv;
%                     angrate(row,:) = langrate;
%             end
%         end
%     end
%     VN100.time    = data(vidx,M);
%     VN100.Yaw     = yaw;
%     VN100.Pitch   = pitch;
%     VN100.Roll    = roll;
%     VN100.Quat    = quat;
%     VN100.MagV    = magv;
%     VN100.AccV    = accv;
%     VN100.AngRate = angrate;
    
    for i=1:N
        if data(i,2)~=0
            idx = find(data(i,:)==13);
            if ~isempty(idx) && all(idx==[35 176])
                vidx = [vidx; i];
                %'#$VNYPR,-096.72,+007.34,-009.81*50'
                top = [top; sscanf(char(data(i, 2:idx(1)-1)),'$VNYPR,%f,%f,%f*%d')'];
                %'$VNQMR,+0.021375,-0.049923,+0.797361,-0.601055,-0.2354,+0.8029,+1.8875,+00.795,-00.412,-09.709,-00.0201,-00.0055,-00.0149*76'
                bot = [bot; sscanf(char(data(i,52:idx(2)-1)),'$VNQMR,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f*%d')'];
            end
        end
    end
    VN100.time    = data(vidx,M);
    if ~isempty(top)
        VN100.Yaw     = top(:,1);
        VN100.Pitch   = top(:,2);
        VN100.Roll    = top(:,3);
    else
        VN100.Yaw     = [];
        VN100.Pitch   = [];
        VN100.Roll    = [];
    end
    if ~isempty(top)
        VN100.Quat    = bot(:,1:4);
        VN100.MagV    = bot(:,5:7);
        VN100.AccV    = bot(:,8:10);
        VN100.AngRate = bot(:,11:13);
    else
        VN100.Quat    = [];
        VN100.MagV    = [];
        VN100.AccV    = [];
        VN100.AngRate = [];
    end
return

