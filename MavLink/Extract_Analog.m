%%
clear all
%%
% dfile = '2011-09-06 01-08-52.tlog';
% pid = fopen(dfile);
% data = fread(pid,'uchar');
% cnt = 1;
% A = [];
% while (~isempty(cnt))
%     [tline cnt] = fgets(pid);
%     disp(tline(1:end-2))
%     idx = strfind(tline,'__mavlink_analog_channels_t');
%     if (~isempty(idx))
%         data = tline(idx+28:end);
%         %A = [A; textscan(tline,'%s %s %s %s %s %s %s chan01=%d chan02=%d chan03=%d chan04=%d chan05=%d chan06=%d chan07=%d chan08=%d chan09=%d chan10=%d chan11=%d chan12=%d chan13=%d chan14=%d chan15=%d chan16=%d %s %s')];
%         A = [A; textscan(data,'chan01=%d chan02=%d chan03=%d chan04=%d chan05=%d chan06=%d chan07=%d chan08=%d chan09=%d chan10=%d chan11=%d chan12=%d chan13=%d chan14=%d chan15=%d chan16=%d %s %s')];
%     end
% end
% 
% A = double(cell2mat(A(:,1:16)));
% 
% fclose(pid)
% disp('Done')

%%
dfile = '2011-09-08 02-37-59.txt';
dfile = '2011-09-07 01-59-44.txt';
%%
pid = fopen(dfile);
cnt = 1;
A = [];
while (~isempty(cnt))
    [tline cnt] = fgets(pid);
    idx = strfind(tline,'__mavlink_analog_channels_t');
    if (~isempty(idx))
        disp(tline(1:end-2))
        data = tline(idx+28:end);
        %A = [A; textscan(tline,'%s %s %s %s %s %s %s chan01=%d chan02=%d chan03=%d chan04=%d chan05=%d chan06=%d chan07=%d chan08=%d chan09=%d chan10=%d chan11=%d chan12=%d chan13=%d chan14=%d chan15=%d chan16=%d %s %s')];
        A = [A; textscan(data,'chan01=%d chan02=%d chan03=%d chan04=%d chan05=%d chan06=%d chan07=%d chan08=%d chan09=%d chan10=%d chan11=%d chan12=%d chan13=%d chan14=%d chan15=%d chan16=%d %s %s')];
    end
end

Analog = double(cell2mat(A(:,1:16)));
%%
save(strcat(dfile(1:end-4),'_Analog.mat'),'Analog');

%%
fclose(pid)
disp('Done')

%%
FwdCurr = Analog(:,13);
AftCurr = Analog(:,14);

hold off
plot(FwdCurr,'b')
hold on
plot(AftCurr,'r')
plot(smooth(FwdCurr,80),'c','LineWidth',3)
plot(smooth(AftCurr,80),'m','LineWidth',3)
grid on
