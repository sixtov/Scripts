%%
clear
[num txt Vraw] = xlsread('New BHM pin traces.xlsx','Voltage Cal');
[num txt Craw] = xlsread('New BHM pin traces.xlsx','Current Cal');
[num txt Traw] = xlsread('New BHM pin traces.xlsx','Temperature Cal');

%% Voltage
BHM.(Vraw{2,1}).name = Vraw{2,1};
BHM.(Vraw{2,2}).name = Vraw{2,2};
BHM.(Vraw{2,3}).name = Vraw{2,3};
BHM.(Vraw{2,5}).name = Vraw{2,5};
BHM.(Vraw{2,6}).name = Vraw{2,6};
BHM.(Vraw{2,7}).name = Vraw{2,7};

BHM.(Vraw{2,1}).data = cell2mat(Vraw(3:12,1));
BHM.(Vraw{2,2}).data = cell2mat(Vraw(3:12,2));
BHM.(Vraw{2,3}).data = cell2mat(Vraw(3:12,3));
BHM.(Vraw{2,5}).data = cell2mat(Vraw(3:12,5));
BHM.(Vraw{2,6}).data = cell2mat(Vraw(3:12,6));
BHM.(Vraw{2,7}).data = cell2mat(Vraw(3:12,7));

%% Current
BHM.(Craw{2,1}).name = Craw{2,1};
BHM.(Craw{2,2}).name = Craw{2,2};
BHM.(Craw{2,3}).name = Craw{2,3};
BHM.(Craw{2,4}).name = Craw{2,4};
BHM.(Craw{2,5}).name = Craw{2,5};
BHM.(Craw{2,6}).name = Craw{2,6};
BHM.(Craw{2,7}).name = Craw{2,7};

BHM.(Craw{2,1}).data = cell2mat(Craw(3:21,1));
BHM.(Craw{2,2}).data = cell2mat(Craw(3:21,2));
BHM.(Craw{2,3}).data = cell2mat(Craw(3:21,3));
BHM.(Craw{2,4}).data = cell2mat(Craw(3:21,4));
BHM.(Craw{2,5}).data = cell2mat(Craw(3:21,5));
BHM.(Craw{2,6}).data = cell2mat(Craw(3:21,6));
BHM.(Craw{2,7}).data = cell2mat(Craw(3:21,7));

%% Temperature
BHM.(Traw{2,1}).name = Traw{2,1};
BHM.(Traw{2,2}).name = Traw{2,2};
BHM.(Traw{2,3}).name = Traw{2,3};
BHM.(Traw{2,4}).name = Traw{2,4};
BHM.(Traw{2,5}).name = Traw{2,5};

BHM.(Traw{2,1}).data = cell2mat(Traw(3:16,1));
BHM.(Traw{2,2}).data = cell2mat(Traw(3:16,2));
BHM.(Traw{2,3}).data = cell2mat(Traw(3:16,3));
BHM.(Traw{2,4}).data = cell2mat(Traw(3:16,4));
BHM.(Traw{2,5}).data = cell2mat(Traw(3:16,5));

%%
BHM.LLF20V.coef = polyfit(BHM.LLF20V.data,BHM.Bat20V.data,1);
BHM.LLF20C.coef = polyfit(BHM.LLF20C.data,BHM.Current.data,1);
BHM.LLF20T.coef = polyfit(BHM.LLF20T.data,BHM.Temp.data,1);

BHM.LRF40V.coef = polyfit(BHM.LRF40V.data,BHM.Bat40V.data,1);
BHM.LRF40C.coef = polyfit(BHM.LRF40C.data,BHM.Current.data,1);
BHM.LRF40T.coef = polyfit(BHM.LRF40T.data,BHM.Temp.data,1);

BHM.ULA20V.coef = polyfit(BHM.ULA20V.data,BHM.Bat20V.data,1);
BHM.ULA20C.coef = polyfit(BHM.ULA20C.data,BHM.Current.data,1);
BHM.ULA20T.coef = polyfit(BHM.ULA20T.data,BHM.Temp.data,1);

BHM.URA40V.coef = polyfit(BHM.URA40V.data,BHM.Bat40V.data,1);
BHM.URA40C.coef = polyfit(BHM.URA40C.data,BHM.Current.data,1);
BHM.URA40T.coef = polyfit(BHM.URA40T.data,BHM.Temp.data,1);

%%
%slvFigure(BHM.LLF20V.name);
figure; hold off
plot(BHM.LLF20V.data,BHM.Bat20V.data,'bo'); hold on
plot(BHM.ULA20V.data,BHM.Bat20V.data,'ro')
plot(BHM.LLF20V.data,polyval(BHM.LLF20V.coef,BHM.LLF20V.data),'b')
plot(BHM.ULA20V.data,polyval(BHM.ULA20V.coef,BHM.ULA20V.data),'r')
grid on
title('20V Batteries')
xlabel('Raw: Voltage (V)')
ylabel('EU: Voltage (V)')
lString = [{sprintf('LLF20V: %.2f*m + %.2f',BHM.LLF20V.coef)}...
           {sprintf('ULA20V: %.2f*m + %.2f',BHM.ULA20V.coef)}];
legend(lString,'Location','SouthEast')

figure; hold off
plot(BHM.LRF40V.data,BHM.Bat40V.data,'bo'); hold on
plot(BHM.URA40V.data,BHM.Bat40V.data,'ro')
plot(BHM.LRF40V.data,polyval(BHM.LRF40V.coef,BHM.LRF40V.data),'b')
plot(BHM.URA40V.data,polyval(BHM.URA40V.coef,BHM.URA40V.data),'r')
grid on
title('40V Batteries')
xlabel('Raw: Voltage (V)')
ylabel('EU: Voltage (V)')
lString = [{sprintf('LRF40V: %.2f*m + %.2f',BHM.LRF40V.coef)}...
           {sprintf('URA40V: %.2f*m + %.2f',BHM.URA40V.coef)}];
legend(lString,'Location','SouthEast')

%%
%slvFigure(BHM.LLF20V.name);
figure; hold off
plot(BHM.LLF20C.data,BHM.Current.data,'bo'); hold on
plot(BHM.ULA20C.data,BHM.Current.data,'ro')
plot(BHM.LRF40C.data,BHM.Current.data,'go')
plot(BHM.URA40C.data,BHM.Current.data,'co')
plot(BHM.LLF20C.data,polyval(BHM.LLF20C.coef,BHM.LLF20C.data),'b')
plot(BHM.ULA20C.data,polyval(BHM.ULA20C.coef,BHM.ULA20C.data),'r')
plot(BHM.LRF40C.data,polyval(BHM.LRF40C.coef,BHM.LRF40C.data),'g')
plot(BHM.URA40C.data,polyval(BHM.URA40C.coef,BHM.URA40C.data),'c')
grid on
title('Current Sensors')
xlabel('Raw: Voltage (V)')
ylabel('EU: Current (A)')
lString = [{sprintf('LLF20C: %.2f*m + %.2f',BHM.LLF20C.coef)}...
           {sprintf('ULA20C: %.2f*m + %.2f',BHM.ULA20C.coef)}...
           {sprintf('LRF40C: %.2f*m + %.2f',BHM.LRF40C.coef)}...
           {sprintf('URA40C: %.2f*m + %.2f',BHM.URA40C.coef)}];
legend(lString,'Location','SouthEast')

%%
%slvFigure(BHM.LLF20V.name);
figure; hold off
plot(BHM.LLF20T.data,BHM.Temp.data,'bo'); hold on
plot(BHM.ULA20T.data,BHM.Temp.data,'ro')
plot(BHM.LRF40T.data,BHM.Temp.data,'go')
plot(BHM.URA40T.data,BHM.Temp.data,'co')
plot(BHM.LLF20T.data,polyval(BHM.LLF20T.coef,BHM.LLF20T.data),'b')
plot(BHM.ULA20T.data,polyval(BHM.ULA20T.coef,BHM.ULA20T.data),'r')
plot(BHM.LRF40T.data,polyval(BHM.LRF40T.coef,BHM.LRF40T.data),'g')
plot(BHM.URA40T.data,polyval(BHM.URA40T.coef,BHM.URA40T.data),'c')
grid on
title('Temperature Sensors')
xlabel('Raw: Voltage (V)')
ylabel('EU: Temperature (F)')
lString = [{sprintf('LLF20T: %.2f*m + %.2f',BHM.LLF20T.coef)}...
           {sprintf('ULA20T: %.2f*m + %.2f',BHM.ULA20T.coef)}...
           {sprintf('LRF40T: %.2f*m + %.2f',BHM.LRF40T.coef)}...
           {sprintf('URA40T: %.2f*m + %.2f',BHM.URA40T.coef)}];
legend(lString,'Location','SouthEast')

%% Other Current Sensors
[num txt Oraw] = xlsread('New BHM pin traces.xlsx','Current Cal Other Sensors');

CS.(Oraw{2,1}).name = Oraw{2,1};
CS.(Oraw{2,2}).name = Oraw{2,2};
CS.(Oraw{2,3}).name = Oraw{2,3};
CS.(Oraw{2,4}).name = Oraw{2,4};
CS.(Oraw{2,5}).name = Oraw{2,5};
CS.(Oraw{2,6}).name = Oraw{2,6};
CS.(Oraw{2,7}).name = Oraw{2,7};
CS.(Oraw{2,8}).name = Oraw{2,8};
CS.(Oraw{2,9}).name = Oraw{2,9};
CS.(Oraw{2,10}).name = Oraw{2,10};
CS.(Oraw{2,11}).name = Oraw{2,11};

CS.(Oraw{2,1}).data = cell2mat(Oraw(3:44,1));
CS.(Oraw{2,2}).data = cell2mat(Oraw(3:44,2));
CS.(Oraw{2,3}).data = cell2mat(Oraw(3:44,3));
CS.(Oraw{2,4}).data = cell2mat(Oraw(3:44,4));
CS.(Oraw{2,5}).data = cell2mat(Oraw(3:44,5));
CS.(Oraw{2,6}).data = cell2mat(Oraw(3:44,6));
CS.(Oraw{2,7}).data = cell2mat(Oraw(3:44,7));
CS.(Oraw{2,8}).data = cell2mat(Oraw(3:44,8));
CS.(Oraw{2,9}).data = cell2mat(Oraw(3:44,9));
CS.(Oraw{2,10}).data = cell2mat(Oraw(3:44,10));
CS.(Oraw{2,11}).data = cell2mat(Oraw(3:44,11));

CS.C1.coef = polyfit(CS.C1.data,CS.Current.data,1);
CS.C2.coef = polyfit(CS.C2.data,CS.Current.data,1);
CS.C3.coef = polyfit(CS.C3.data,CS.Current.data,1);
CS.C4.coef = polyfit(CS.C4.data,CS.Current.data,1);
CS.C5.coef = polyfit(CS.C5.data,CS.Current.data,1);
CS.C6.coef = polyfit(CS.C6.data,CS.Current.data,1);
CS.C7.coef = polyfit(CS.C7.data,CS.Current.data,1);
CS.C8.coef = polyfit(CS.C8.data,CS.Current.data,1);
CS.C9.coef = polyfit(CS.C9.data,CS.Current.data,1);

%%
slvFigure('Current Cal');
hold off
plot(CS.C1.data,CS.Current.data,'bo'); hold on
plot(CS.C2.data,CS.Current.data,'ro')
plot(CS.C3.data,CS.Current.data,'go')
plot(CS.C4.data,CS.Current.data,'co')
plot(CS.C5.data,CS.Current.data,'bs')
plot(CS.C6.data,CS.Current.data,'rs')
plot(CS.C7.data,CS.Current.data,'gs')
plot(CS.C8.data,CS.Current.data,'cs')
plot(CS.C9.data,CS.Current.data,'bd')
plot(CS.C1.data,polyval(CS.C1.coef,CS.C1.data),'b')
plot(CS.C2.data,polyval(CS.C2.coef,CS.C2.data),'r')
plot(CS.C3.data,polyval(CS.C3.coef,CS.C3.data),'g')
plot(CS.C4.data,polyval(CS.C4.coef,CS.C4.data),'c')
plot(CS.C5.data,polyval(CS.C5.coef,CS.C5.data),'b')
plot(CS.C6.data,polyval(CS.C6.coef,CS.C6.data),'r')
plot(CS.C7.data,polyval(CS.C7.coef,CS.C7.data),'g')
plot(CS.C8.data,polyval(CS.C8.coef,CS.C8.data),'c')
plot(CS.C9.data,polyval(CS.C9.coef,CS.C9.data),'b')
grid on
title('Current Sensors')
xlabel('Raw: Voltage (V)')
ylabel('EU: Current (A)')
lString = [{sprintf('C1: %.2f*m + %.2f',CS.C1.coef)}...
           {sprintf('C2: %.2f*m + %.2f',CS.C2.coef)}...
           {sprintf('C3: %.2f*m + %.2f',CS.C3.coef)}...
           {sprintf('C4: %.2f*m + %.2f',CS.C4.coef)}...
           {sprintf('C5: %.2f*m + %.2f',CS.C5.coef)}...
           {sprintf('C6: %.2f*m + %.2f',CS.C6.coef)}...
           {sprintf('C7: %.2f*m + %.2f',CS.C7.coef)}...
           {sprintf('C8: %.2f*m + %.2f',CS.C8.coef)}...
           {sprintf('C9: %.2f*m + %.2f',CS.C9.coef)}];
legend(lString,'Location','SouthEast')


%%
slvFigure('Current Cal Subplot');
subplot(3,3,1); hold off; plot(CS.C1.data,CS.Current.data,'o'); hold on; plot(CS.C1.data,polyval(CS.C1.coef,CS.C1.data)); grid on; title('C1'); xlabel('Raw: Voltage (V)'); ylabel('EU: Current (A)');legend(sprintf('C1: %.2f*m + %.2f',CS.C1.coef),'Location','SouthEast')
subplot(3,3,2); hold off; plot(CS.C2.data,CS.Current.data,'o'); hold on; plot(CS.C2.data,polyval(CS.C2.coef,CS.C2.data)); grid on; title('C2'); xlabel('Raw: Voltage (V)'); ylabel('EU: Current (A)');legend(sprintf('C2: %.2f*m + %.2f',CS.C2.coef),'Location','SouthEast')
subplot(3,3,3); hold off; plot(CS.C3.data,CS.Current.data,'o'); hold on; plot(CS.C3.data,polyval(CS.C3.coef,CS.C3.data)); grid on; title('C3'); xlabel('Raw: Voltage (V)'); ylabel('EU: Current (A)');legend(sprintf('C3: %.2f*m + %.2f',CS.C3.coef),'Location','SouthEast')
subplot(3,3,4); hold off; plot(CS.C4.data,CS.Current.data,'o'); hold on; plot(CS.C4.data,polyval(CS.C4.coef,CS.C4.data)); grid on; title('C4'); xlabel('Raw: Voltage (V)'); ylabel('EU: Current (A)');legend(sprintf('C4: %.2f*m + %.2f',CS.C4.coef),'Location','SouthEast')
subplot(3,3,5); hold off; plot(CS.C5.data,CS.Current.data,'o'); hold on; plot(CS.C5.data,polyval(CS.C5.coef,CS.C5.data)); grid on; title('C5'); xlabel('Raw: Voltage (V)'); ylabel('EU: Current (A)');legend(sprintf('C5: %.2f*m + %.2f',CS.C5.coef),'Location','SouthEast')
subplot(3,3,6); hold off; plot(CS.C6.data,CS.Current.data,'o'); hold on; plot(CS.C6.data,polyval(CS.C6.coef,CS.C6.data)); grid on; title('C6'); xlabel('Raw: Voltage (V)'); ylabel('EU: Current (A)');legend(sprintf('C6: %.2f*m + %.2f',CS.C6.coef),'Location','SouthEast')
subplot(3,3,7); hold off; plot(CS.C7.data,CS.Current.data,'o'); hold on; plot(CS.C7.data,polyval(CS.C7.coef,CS.C7.data)); grid on; title('C7'); xlabel('Raw: Voltage (V)'); ylabel('EU: Current (A)');legend(sprintf('C7: %.2f*m + %.2f',CS.C7.coef),'Location','SouthEast')
subplot(3,3,8); hold off; plot(CS.C8.data,CS.Current.data,'o'); hold on; plot(CS.C8.data,polyval(CS.C8.coef,CS.C8.data)); grid on; title('C8'); xlabel('Raw: Voltage (V)'); ylabel('EU: Current (A)');legend(sprintf('C8: %.2f*m + %.2f',CS.C8.coef),'Location','SouthEast')
subplot(3,3,9); hold off; plot(CS.C9.data,CS.Current.data,'o'); hold on; plot(CS.C9.data,polyval(CS.C9.coef,CS.C9.data)); grid on; title('C9'); xlabel('Raw: Voltage (V)'); ylabel('EU: Current (A)');legend(sprintf('C9: %.2f*m + %.2f',CS.C9.coef),'Location','SouthEast')


%%
slvFigure('Fit Error');
m = 1/0.019;
b = -m*2.5;
dcoef = [m b];
xticks = [1.5:0.25:3.5];
subplot(3,3,1); plot(CS.C1.data,CS.Current.data-polyval(CS.C1.coef,CS.C1.data),'-bo'); grid on; set(gca,'XTick',xticks); title('C1'); xlabel('Raw: Voltage (V)'); ylabel('EU: Fit Error (A)')
subplot(3,3,2); plot(CS.C2.data,CS.Current.data-polyval(CS.C2.coef,CS.C2.data),'-bo'); grid on; set(gca,'XTick',xticks); title('C2'); xlabel('Raw: Voltage (V)'); ylabel('EU: Fit Error (A)')
subplot(3,3,3); plot(CS.C3.data,CS.Current.data-polyval(CS.C3.coef,CS.C3.data),'-bo'); grid on; set(gca,'XTick',xticks); title('C3'); xlabel('Raw: Voltage (V)'); ylabel('EU: Fit Error (A)')
subplot(3,3,4); plot(CS.C4.data,CS.Current.data-polyval(CS.C4.coef,CS.C4.data),'-bo'); grid on; set(gca,'XTick',xticks); title('C4'); xlabel('Raw: Voltage (V)'); ylabel('EU: Fit Error (A)')
subplot(3,3,5); plot(CS.C5.data,CS.Current.data-polyval(CS.C5.coef,CS.C5.data),'-bo'); grid on; set(gca,'XTick',xticks); title('C5'); xlabel('Raw: Voltage (V)'); ylabel('EU: Fit Error (A)')
subplot(3,3,6); plot(CS.C6.data,CS.Current.data-polyval(CS.C6.coef,CS.C6.data),'-bo'); grid on; set(gca,'XTick',xticks); title('C6'); xlabel('Raw: Voltage (V)'); ylabel('EU: Fit Error (A)')
subplot(3,3,7); plot(CS.C7.data,CS.Current.data-polyval(CS.C7.coef,CS.C7.data),'-bo'); grid on; set(gca,'XTick',xticks); title('C7'); xlabel('Raw: Voltage (V)'); ylabel('EU: Fit Error (A)')
subplot(3,3,8); plot(CS.C8.data,CS.Current.data-polyval(CS.C8.coef,CS.C8.data),'-bo'); grid on; set(gca,'XTick',xticks); title('C8'); xlabel('Raw: Voltage (V)'); ylabel('EU: Fit Error (A)')
subplot(3,3,9); plot(CS.C9.data,CS.Current.data-polyval(CS.C9.coef,CS.C9.data),'-bo'); grid on; set(gca,'XTick',xticks); title('C9'); xlabel('Raw: Voltage (V)'); ylabel('EU: Fit Error (A)')
