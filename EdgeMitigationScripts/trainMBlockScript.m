%% Setup Parameter-Signal Combinations

pair = [{'str v cg'} {'str v ob'} {'cg v ob'} {'cg v ct'} {'ob v ct'}];
NC = 6;
fields = fieldnames(plist{1});
fN = length(fields);
% fields = fields(fN:-1:1);
pN = size(plist{1}.(fields{1}),2);
list = (1:fN*pN)';
c = combnk(list,NC);
cN = length(c);
idx = randperm(cN);
c = c(idx,:);
[col row] = ind2sub([pN fN],c);

N = length(clist);
GROUP = [];
for i=1:N
    GROUP = [GROUP; clist{i}];
end

%% Process Parameter-Signal Combinations
NROC = 100;
MOD = 1000;
cnt = 1;
mroc = 0;

field = cell(NC,1);
cnum = zeros(NC,1);
dPARAM = cell(N,1);
for i=1:N
    dPARAM{i} = zeros(dN(i),NC);
end
for i=1:cN
    PARAM = [];
    for k=1:N
        label = [];
        for j=1:NC
            field(j) = fields(row(i,j));
            cnum(j) = col(i,j);
            label = [label sprintf('%s_%02d  ',fields{row(i,j)},col(i,j))];
            if j<NC, label = [label 'vs  ']; end
            dPARAM{k}(:,j) = plist{k}.(field{j})(:,cnum(j));
        end
        PARAM = [PARAM; dPARAM{k}];
    end
    try
        [C,errq,P,logp,coeff] = classify(PARAM,PARAM,GROUP,'quadratic');
    catch
        if ~mod(i,MOD)
            disp(sprintf('%4d) FAIL %s',floor(i/MOD),label))
        end
        continue
    end
    coef = coeff(1,2);
    troc = getMROC (GROUP,C, coef.const,coef.linear,coef.quadratic);
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
            zroc = troc;
            zroc.ACC = 0;
            roc(1:NROC) = zroc;
            roc(1) = troc;
            clear zroc;
        else
            roc(cnt) = troc;
        end
        disp(sprintf('%04d) %0.2f %s',cnt,troc.ACC,troc.label))
        acc = [];
        for k=1:NROC
            acc = [acc roc(k).ACC];
        end
        [mroc cnt] = min(acc);
    else
        if ~mod(i,MOD)
            disp(sprintf('%4d) %0.2f %s',floor(i/MOD),troc.ACC,troc.label))
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
    disp(sprintf('%04d) %0.3f %s',i,roc(i).ACC,roc(i).label))
end

save('roc.mat','roc','pair');

%% Top 100 ROC Parameter-Signal Combinations
%clear
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
