%%
clear
amp = 15;
N = 100;
g1(1:N,1) = 'g'; g1(1:N,2) = '1';
g2(1:N,1) = 'g'; g2(1:N,2) = '2';
g1x =  rand(N,1) * amp;
g2x = -rand(N,1) * amp;
g1y =  rand(N,1) * amp;
g2y = -rand(N,1) * amp;

g2x(5) = -g2x(5);
g2y(5) = -g2y(5);

SL = [g1x; g2x];
SW = [g1y; g2y];
group = [g1; g2];
gColor = ['r'; 'b'];
xd = [SL SW];
y = zeros(N,1);

if (mean(SL-SW) ~= 0) 
    [errq fq coef] = doClassify(1, SL, SW, group, gColor, 'X', 'Y','quadratic', 0 ); 
    K = coef(1);
    L = coef(2:3)';
    Q = [coef(4) coef(5)/2; coef(5)/2 coef(6)];
    for k=1:length(xd)
        y(k) = K + xd(k,:)*L + xd(k,:)*Q*xd(k,:)';
    end
    %classified as group 1 
    idx = find(y>=0); 
    plot(xd(idx,1),xd(idx,2),sprintf('%c.',gColor(1)))
    
    %classified as group 2 
    idx = find(y<0);  
    plot(xd(idx,1),xd(idx,2),sprintf('%c.',gColor(2)))
    
    t2 = [g2x g2y];
    t1 = [g1x g1y];
    roc = getROC (t1, t2, coef);
end
