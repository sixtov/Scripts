function [n,t,r] = Read_FileScopeSignalList_xls(xlsfile,sheet)
%function Read_FileScopeSignalList_xls(xlsfile);
%
% Function reads from the AHRS spreadsheet (xlsfile) 
% and converts the data into matlab workspace 
% variables.
%
% Matlab code is written to the file specified by the string 
% variable mfile, or written to the screen if no file is specified.
%
% $Id: Signal_cals_xlsupdate.m 1 2009-09-11 15:34:33Z Hogge $


% if (~exist('mfile','var') || isempty(mfile))
%     fid=1;  % stdout
% else
%  fid=fopen(mfile,'w');
%   if (fid<0), error(sprintf('Cannot open file: %s\n',mfile));end
% end

%[n,t,r]=xlsread(xlsfile);
[n,t,r]=xlsread(xlsfile,sheet,' ','basic');

% fprintf(fid,'function RefGainBias = %s()\n',mfile(1:end-2));
% fprintf(fid,'%% function RefGainBias = %s()\n',mfile(1:end-2));
% fprintf(fid,'%%\n');
% fprintf(fid,'%% $Id: Signal_cals_xlsupdate.m 1 2009-09-11 15:34:33Z Hogge $\n%\n');
% fprintf(fid,'%%**************** ADC Calibration ****************\n');
% %fprintf(fid,'%% In-flight Voltage Reference: 0) None, 1) CPTV, 2) BAROV 3)MAG3V\n');
% fprintf(fid,'%% Gain (units output/input)\n');
% fprintf(fid,'%% Bias (units of output)\n');
% fprintf(fid,'%%\n%\n');
% fprintf(fid,'%% The following was auto-generated from %s on %s\n\n',xlsfile,datestr(now));
% 
% %for i=[2:63],
% for i=[2:33],
%   fprintf(fid,'RefGainBias.%-15s = [ %d,  %+5.5e,  %+5.5e ];   %% From %s to %s \n',...
%       r{i,3},r{i,4},r{i,5},r{i,6},r{i,7},r{i,8});
% end

% if (fid~=1),fclose(fid);end

end










