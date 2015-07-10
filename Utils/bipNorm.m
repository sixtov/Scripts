function a = bipNorm(b)
    %a = b-mean(b);
    %a = abs(b);
    K = length(b)/5;
    a = smooth(b,200);
    a = a/max(abs(a));
    a = a-a(1);
return