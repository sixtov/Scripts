%% Loads Training Data
clear
ulist = dir('MT_U*');
dlist = dir('MT_D*');
uN = length(ulist);
dN = length(dlist);

up = [];
for i=1:uN
    d = getPc4Data(ulist(i).name);
    up = getParameters(up,[d.strn d.cgaz d.obaz d.ctaz]);
    ug(1:uN,1) = 'U';
end

dp = [];
for i=1:dN
    d = getPc4Data(dlist(i).name);
    dp = getParameters(dp,[d.strn d.cgaz d.obaz d.ctaz]);
    dg(1:dN,1) = 'D';
end

save('p.mat','up','dp','ug','dg','uN','dN');

%% Setup Parameter-Signal Combinations
load('p.mat');

pair = [{'str v cg'} {'str v ob'} {'cg v ob'} {'cg v ct'} {'ob v ct'}];
NC = 6;
fields = fieldnames(up);
fN = length(fields);
% idx = setdiff((1:fN),[4 5 8 9]);
% fields = fields(idx);
pN = size(up.(fields{1}),2);
list = (1:fN*pN)';
c = combnk(list,NC);
cN = length(c);
[col row] = ind2sub([pN fN],c);

GROUP = [ug; dg];

%% Process Parameter-Signal Combinations
clear roc
NROC = 100;
MOD = 1000;
% ctr = 0;
cnt = 1;
mroc = 0;

field = cell(NC,1);
cnum = zeros(NC,1);
uPARAM = zeros(uN,NC);
dPARAM = zeros(dN,NC);
PARAM = zeros(uN+dN,NC);
for i=1:cN
%     ctr = ctr + 1;
    % Quadratic separator curve
    label = [];
    for j=1:NC
%         TEST(j) = 0;
        field(j) = fields(row(i,j));
        cnum(j) = col(i,j);
%         uPARAM(:,j) = up.(fields{row(i,j)})(:,col(i,j));
%         dPARAM(:,j) = dp.(fields{row(i,j)})(:,col(i,j));
        uPARAM(:,j) = up.(field{j})(:,cnum(j));
        dPARAM(:,j) = dp.(field{j})(:,cnum(j));
        PARAM(:,j) = [uPARAM(:,j); dPARAM(:,j)];
        label = [label sprintf('%s_%02d  ',fields{row(i,j)},col(i,j))];
        if j<NC
            label = [label 'vs  '];
        end
    end
    try
%         [C,errq,P,logp,coeff] = classify(TEST,PARAM,GROUP,'quadratic');
        [C,errq,P,logp,coeff] = classify(PARAM,PARAM,GROUP,'quadratic');
        coef = coeff(1,2);
        troc = getROC (uPARAM, dPARAM, coef.const,coef.linear,coef.quadratic);
        troc.coef = coeff;
        troc.label = label;
        troc.field = field;
        troc.cnum = cnum;
        troc.C = C;
        troc.PARAM = PARAM;
        troc.Pmin = min(PARAM);
        troc.Pmax = max(PARAM);
        if troc.ACC>mroc
            if ~exist('roc','var')
                roc(1:NROC) = troc;
            else
                roc(cnt) = troc;
            end
            disp(sprintf('%03d) %0.2f %s',cnt,troc.ACC,troc.label))
            acc = [];
            for k=1:NROC
                acc = [acc roc(k).ACC];
            end
            [mroc cnt] = min(acc);
        else
%             if ~mod(ctr,MOD)
            if ~mod(i,MOD)
                disp(sprintf('%3d) %0.2f %s',floor(i/MOD),troc.ACC,troc.label))
            end
        end
    catch %myE
%         if ~mod(ctr,MOD)
        if ~mod(i,MOD)
            %disp(sprintf('          %s FAILED!',label))
            disp(sprintf('%3d) FAIL %s',floor(i/MOD),label))
        end
    end
    
end

acc = [];
for k=1:NROC
    acc = [acc roc(k).ACC];
end
[sv si] = sort(acc,'descend');
roc = roc(si);

disp(' ')
for i=1:NROC
    disp(sprintf('%03d) %0.3f %s',i,roc(i).ACC,roc(i).label))
end

save('roc.mat','roc');

%% Top 100 ROC Parameter-Signal Combinations
load('roc.mat');

counter = cell(fN+2,pN+2);
for i=1:fN, counter{i+1,1} = fields{i}; end
for i=1:pN, counter{1,i+1} = pair{i}; end
for i=1:fN+1, for j=1:pN+1, counter{i+1,j+1} = 0; end; end
counter{1,1} = ' ';
counter{fN+2,1} = 'Col Total';
counter{1,pN+2} = 'Row Total';
counter{fN+2,pN+2} = ' ';
for i=1:NROC
    for j=1:NC
        fi = 0;
        for k=1:fN
            if strcmp(roc(i).field{j},fields{k})
                fi = k+1;
            end
        end
        pi = roc(i).cnum(j)+1;
        counter{fi,pi} = counter{fi,pi}+1;
    end
end

for i=1:fN, for j=1:pN, counter{i+1,pN+2} = counter{i+1,pN+2} + counter{i+1,j+1}; end; end
for i=1:fN, for j=1:pN, counter{fN+2,j+1} = counter{fN+2,j+1} + counter{i+1,j+1}; end; end
disp(' ')
disp(counter)

%% Attempt to plot classification space
slvFigure('Classifier Space');
NP = size(roc(1).PARAM,1);
for i=1:NROC
    %%%%%%%%%
    subplot(4,4,1)
    for j=1:NP
        pm = 'go';
        switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
        if j==1, hold off; else hold on; end
        plot(roc(i).PARAM(:,1),roc(i).PARAM(:,2),pm); grid on
    end

    subplot(4,4,2)
    for j=1:NP
        pm = 'go';
        switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
        if j==1, hold off; else hold on; end
        plot(roc(i).PARAM(:,1),roc(i).PARAM(:,3),pm); grid on
    end

    subplot(4,4,3)
    for j=1:NP
        pm = 'go';
        switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
        if j==1, hold off; else hold on; end
        plot(roc(i).PARAM(:,1),roc(i).PARAM(:,4),pm); grid on
    end

    subplot(4,4,4)
    for j=1:NP
        pm = 'go';
        switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
        if j==1, hold off; else hold on; end
        plot(roc(i).PARAM(:,1),roc(i).PARAM(:,5),pm); grid on
    end


    
    %%%%%%%%%
    subplot(4,4,5)
    for j=1:NP
        pm = 'go';
        switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
        if j==1, hold off; else hold on; end
        plot(roc(i).PARAM(:,1),roc(i).PARAM(:,6),pm); grid on
    end

    subplot(4,4,6)
    for j=1:NP
        pm = 'go';
        switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
        if j==1, hold off; else hold on; end
        plot(roc(i).PARAM(:,2),roc(i).PARAM(:,3),pm); grid on
    end

    subplot(4,4,7)
    for j=1:NP
        pm = 'go';
        switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
        if j==1, hold off; else hold on; end
        plot(roc(i).PARAM(:,2),roc(i).PARAM(:,4),pm); grid on
    end

    subplot(4,4,8)
    for j=1:NP
        pm = 'go';
        switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
        if j==1, hold off; else hold on; end
        plot(roc(i).PARAM(:,2),roc(i).PARAM(:,5),pm); grid on
    end


    
    %%%%%%%%%
    subplot(4,4,9)
    for j=1:NP
        pm = 'go';
        switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
        if j==1, hold off; else hold on; end
        plot(roc(i).PARAM(:,2),roc(i).PARAM(:,6),pm); grid on
    end

    subplot(4,4,10)
    for j=1:NP
        pm = 'go';
        switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
        if j==1, hold off; else hold on; end
        plot(roc(i).PARAM(:,3),roc(i).PARAM(:,4),pm); grid on
    end

    subplot(4,4,11)
    for j=1:NP
        pm = 'go';
        switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
        if j==1, hold off; else hold on; end
        plot(roc(i).PARAM(:,3),roc(i).PARAM(:,5),pm); grid on
    end

    subplot(4,4,12)
    for j=1:NP
        pm = 'go';
        switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
        if j==1, hold off; else hold on; end
        plot(roc(i).PARAM(:,3),roc(i).PARAM(:,6),pm); grid on
    end


    
    %%%%%%%%%
    subplot(4,4,13)
    for j=1:NP
        pm = 'go';
        switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
        if j==1, hold off; else hold on; end
        plot(roc(i).PARAM(:,4),roc(i).PARAM(:,5),pm); grid on
    end

    subplot(4,4,14)
    for j=1:NP
        pm = 'go';
        switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
        if j==1, hold off; else hold on; end
        plot(roc(i).PARAM(:,4),roc(i).PARAM(:,6),pm); grid on
    end

    subplot(4,4,15)
    for j=1:NP
        pm = 'go';
        switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
        if j==1, hold off; else hold on; end
        plot(roc(i).PARAM(:,5),roc(i).PARAM(:,6),pm); grid on
    end

%     subplot(4,4,16)
%     for j=1:NP
%         pm = 'go';
%         switch(roc(i).C(j)), case 'U'; pm = 'bv'; case 'D'; pm = 'r^'; end
%         if j==1, hold off; else hold on; end
%         plot(roc(i).PARAM(:,),roc(i).PARAM(:,),pm); grid on
%     end
disp(sprintf('(%03d/%03d) Hit any key to continue...',i,NROC))
pause(1)
end    