%% This file specifies the wiring of user channels
%%% in RCATS for the data files in this folder
%%% RCATS configuration on Jun 01 2010
%%
RCATS.config        = 'Prop Test';
DATA.temp1          = rdata(:, 2);              % temp1
%DATA.temp2         = rdata(:, 3);              % temp2
%DATA.voltage       = rdata(:, 7);              % voltage
DATA.current        = rdata(:, 9)*(37/19);      % current (Amp100 instead of Amp25)
DATA.sync           = rdata(:,10);              % I/O 1
DATA.thrust         = rdata(:,11)*10;           % I/O 2
