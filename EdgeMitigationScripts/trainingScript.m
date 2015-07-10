%% Loads Training Data
% clear
% ulist = dir('MT_U*');
% dlist = dir('MT_D*');
% uN = length(ulist);
% dN = length(dlist);
% 
% up = [];
% for i=1:uN
%     d = getPc4Data(ulist(i).name);
%     up = getParameters(up,[d.strn d.cgaz d.obaz d.ctaz]);
%     ug(1:uN,1) = 'U';
% end
% 
% dp = [];
% for i=1:dN
%     d = getPc4Data(dlist(i).name);
%     dp = getParameters(dp,[d.strn d.cgaz d.obaz d.ctaz]);
%     dg(1:dN,1) = 'D';
% end
% 
% save('p.mat','up','dp','ug','dg','uN','dN');

%% Setup Parameter-Signal Combinations

%pair = [{'str v cg'} {'str v ob'} {'cg v ob'} {'cg v ct'} {'ob v ct'}];
pair = up.pairs;
NC = 6;
fields = fieldnames(up);
fN = length(fields);
fields = fields(1:fN-1);
fN = fN-1;
% idx = setdiff((1:fN),[4 5 8 9]);
% fields = fields(idx);
pN = size(up.(fields{1}),2);

GROUP = [ug; dg];

%%
pName = [];
parmIdx = [];
pairIdx = [];
for j=1:pN
    for i=1:fN
        ufPARAM(:,sub2ind([pN fN],j,i)) = up.(fields{i})(:,j);
        dfPARAM(:,sub2ind([pN fN],j,i)) = dp.(fields{i})(:,j);
        pName = [pName; {sprintf('%s_%02d',fields{i},j)}];
        parmIdx = [parmIdx; i];
        pairIdx = [pairIdx; j];
    end
end
fPARAM = [ufPARAM; dfPARAM];
cPARAM = cov(fPARAM);
N = length(cPARAM);
R = rank(cPARAM);
while R<N
    [V Dv] = eig(cPARAM);
    D = diag(Dv);
    [aD si] = sort(abs(D));
    D = D(si);
    disp(sprintf('Removed %s',pName{si(1)}))
    fPARAM = fPARAM(:,si(2:N));
    pName  = pName(si(2:N));
    parmIdx = parmIdx(si(2:N));
    pairIdx = pairIdx(si(2:N));
    cPARAM = cov(fPARAM);
    N = length(cPARAM);
    R = rank(cPARAM);
end
[V Dv] = eig(cPARAM);
D = diag(Dv);
[D si] = sort(D);

%%
disp(sprintf('Classify using %s',sprintf('''%s'' ',pName{:})))
[C,errq,P,logp,coeff] = classify(fPARAM,fPARAM,GROUP,'quadratic');


%% Process Parameter-Signal Combinations
list = (1:N)';
for NC=2:N
    
    if exist('roc','var'), clear roc; end
    c = combnk(list,NC);
    cN = size(c,1);
    
    disp(' ')
    disp('*---------------------------------------------')
    disp(sprintf('Grouping=%d  Size=%d',NC,cN))
    %[col row] = ind2sub([pN fN],c);

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
            field(j) = fields(parmIdx(c(i,j)));
            cnum(j) = pairIdx(c(i,j));
    %         uPARAM(:,j) = up.(fields{row(i,j)})(:,col(i,j));
    %         dPARAM(:,j) = dp.(fields{row(i,j)})(:,col(i,j));
            uPARAM(:,j) = up.(field{j})(:,cnum(j));
            dPARAM(:,j) = dp.(field{j})(:,cnum(j));
            PARAM(:,j) = [uPARAM(:,j); dPARAM(:,j)];
            label = [label sprintf('%s_%02d  ',field{j},cnum(j))];
            if j<NC
                label = [label 'vs  '];
            end
        end
        try
    %         [C,errq,P,logp,coeff] = classify(TEST,PARAM,GROUP,'quadratic');
            cPARAM = cov(PARAM);
            N = length(cPARAM);
            R = rank(cPARAM);
            [V Dv] = eig(cPARAM);
            D = diag(Dv);
            [aD si] = sort(abs(D));
            D = D(si);
            [C,errq,P,logp,coeff] = classify(PARAM,PARAM,GROUP,'quadratic');
            coef = coeff(1,2);
            troc = getROC (uPARAM, dPARAM, coef.const,coef.linear,coef.quadratic);
            troc.label = label;
            troc.field = field;
            troc.cnum = cnum;
            troc.C = C;
            troc.PARAM = PARAM;
            troc.GROUP = GROUP;
            troc.Pmin = min(PARAM);
            troc.Pmax = max(PARAM);
            if troc.ACC>mroc
                if ~exist('roc','var')
                    roc(1:NROC) = troc;
                else
                    roc(cnt) = troc;
                end
                %disp(sprintf('%03d) %0.2f %s',cnt,troc.ACC,troc.label))
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
    %     catch myE
        catch
    %         if ~mod(ctr,MOD)
            if ~mod(i,MOD)
                %disp(sprintf('          %s FAILED!',label))
                disp(sprintf('%3d) FAIL %s',floor(i/MOD),label))
            end
        end

    end

    if exist('roc','var')
        acc = [];
        for k=1:NROC
            acc = [acc roc(k).ACC];
        end
        [sv si] = sort(acc,'descend');
        roc = roc(si);

        disp(' ')
        %for i=1:NROC
        for i=1:5
            disp(sprintf('%03d) %0.3f %s',i,roc(i).ACC,roc(i).label))
        end

        save(sprintf('roc_%02d.mat',NC),'roc','pair');

        %% Top 100 ROC Parameter-Signal Combinations
        %clear
        load(sprintf('roc_%02d.mat',NC));

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
    else
        disp('ROC is empty')
    end
end
