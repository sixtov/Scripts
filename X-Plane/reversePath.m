function rp = reversePath(np)
    rp = flipud(np);
    rp(:,6) = mod(rp(:,6)+180,360);
return