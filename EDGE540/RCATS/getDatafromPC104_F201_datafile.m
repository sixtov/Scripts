%%
%junk = pc104.data(2:end,1:73)';
junk = pc104.data(5:end,[1:73 151:224])';
junk = char(junk);
fid = fopen('junk.txt','w');
fwrite(fid,junk);
fclose(fid);
