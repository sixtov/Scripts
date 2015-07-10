function clss = classifyUsingParams(p1x,p1y,p2x,p2y,p3x,p3y,kgroup,list)
%%  Copy and Paste this section into classifyUsingParams.m  %%
    %% Using roc(41)  (lf_w vs lf_freq)
    %% Using roc(36)  (lf_c vs pole1_a)
    %% Using roc(16)  (slope vs lf_w)
 
    %% To be used as enumerators
    U = 1; % Undamaged
    D = 2; % Damaged
 
    %%           Undamaged [y is (+)]    Damaged [y is (-)]
    % Classifier #1
    % Classifier Weights
    weight(U,1) = 0.750000; 
    weight(D,1) = 0.809524; 
    % Classifier Coefficients
    K(1) = 4.595250;
    L(:,1) = [-0.108437; -0.885553];
    Q(:,:,1) = [-0.000362 0.007738; 0.007738 0.036565];
    xrange(:,1) = [5.211975; 67.468943];
    yrange(:,1) = [3.636762; 10.940757];
     
    % Classifier #2
    % Classifier Weights
    weight(U,2) = 0.777778; 
    weight(D,2) = 0.738095; 
    % Classifier Coefficients
    K(2) = 15.648081;
    L(:,2) = [0.102261; -8.309140];
    Q(:,:,2) = [0.000179 -0.003839; -0.003839 1.237892];
    xrange(:,2) = [-77.608543; -0.019480];
    yrange(:,2) = [0.000000; 3.141593];
     
    % Classifier #3
    % Classifier Weights
    weight(U,3) = 0.888889; 
    weight(D,3) = 0.619048; 
    % Classifier Coefficients
    K(3) = -1.698848;
    L(:,3) = [-0.100614; 0.131563];
    Q(:,:,3) = [-0.001438 0.001312; 0.001312 0.000121];
    xrange(:,3) = [-77.288489; -0.694499];
    yrange(:,3) = [5.211975; 67.468943];
     
%%  End of Copy and Paste Section
     
    x1 = [p1x p1y];
    x2 = [p2x p2y];
    x3 = [p3x p3y];
    
    N = length(p1x);
    y1 = zeros(N,1);
    y2 = zeros(N,1);
    y3 = zeros(N,1);
    state = zeros(N,1);
    w  = zeros(3,1);
    for k=1:N
        y1(k) = K(1) + x1(k,:)*L(:,1) + x1(k,:)*Q(:,:,1)*x1(k,:)';
        y2(k) = K(2) + x2(k,:)*L(:,2) + x2(k,:)*Q(:,:,2)*x2(k,:)';
        y3(k) = K(3) + x3(k,:)*L(:,3) + x3(k,:)*Q(:,:,3)*x3(k,:)';
        
        y = [y1(k); y2(k); y3(k)];
        
        if (y1(k)>0), w(1)=weight(U,1); else w(1)=weight(D,1); end
        if (y2(k)>0), w(2)=weight(U,2); else w(2)=weight(D,2); end
        if (y3(k)>0), w(3)=weight(U,3); else w(3)=weight(D,3); end
        
        state(k) = dot(w/norm(w),y/norm(y));
        if state(k)>0, c = 'U'; dFlag(k,1) = 0; else c = 'D'; dFlag(k,1) = 1; end
        group(k,1) = c;
        if ~isempty(kgroup)
            if (c==kgroup(k)), star = ' '; else star = '*'; end
            if (c~=kgroup(k))
                disp(sprintf('%3.3d) [%6.3f %6.3f %6.3f] [%c] [%c] %c - %s',k,y,c,kgroup(k),star,list{k}))
            end
        end
    end
    clss.x1 = x1;
    clss.x2 = x2;
    clss.x3 = x3;
    clss.y1 = y1;
    clss.y2 = y2;
    clss.y3 = y3;
    clss.state = state;
    clss.group = group;
    clss.dFlag = dFlag;
    clss.Kgroup = kgroup;
    clss.xrange = xrange;
    clss.yrange = yrange;
    clss.f1 = sprintf('0 = %g+%g*x+%g*y+%g*x^2+%g*x.*y+%g*y.^2',...
                K(1),L(:,1),Q(1,1,1),Q(1,2,1)+Q(2,1,1),Q(2,2,1));
    clss.f2 = sprintf('0 = %g+%g*x+%g*y+%g*x^2+%g*x.*y+%g*y.^2',...
                K(2),L(:,2),Q(1,1,2),Q(1,2,2)+Q(2,1,2),Q(2,2,2));
    clss.f3 = sprintf('0 = %g+%g*x+%g*y+%g*x^2+%g*x.*y+%g*y.^2',...
                K(3),L(:,3),Q(1,1,3),Q(1,2,3)+Q(2,1,3),Q(2,2,3));
return
