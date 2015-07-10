function handle=slvPaperFigure(varargin)
h=findobj;
k=0;
if nargin>0, label = varargin{1}; end
if length(h)>1
    for i=2:length(h)
        if strcmp(get(h(i),'Tag'),label)
            k=i;
            break;
        end
    end
end
if k==0
%     handle=figure('Tag',label,'Name',label,'NumberTitle','off','WindowStyle','docked','Renderer','OpenGL',varargin{2:end}); % Create Figure
    handle=figure('Tag',label,'Name',label,'NumberTitle','off','Renderer','OpenGL',varargin{2:end}); % Create Figure
else
    handle=figure(h(k));                    % Recall Figure
end


%%% Apply Standard Formating to paper plots
% Make all plots 3 inches wide by 2.5 inches tall
% clf,
set(gcf,'Units','inches');
fp = get(gcf,'Position');
fp = [fp(1:2) 3.0 2.5];
% set(gcf,'Units','inches','Position',fp,'NumberTitle','off','Toolbar','none');
set(gcf,'Position',fp,'NumberTitle','off','Toolbar','none');
% %  Axes setup.
% set(gca,'Position',[0.15 0.17 0.82 0.70]);
% % set(gca,'Position',[0.19 0.17 0.78 0.70]);
%  Set standard appearance.
grid on,
set(get(gca,'Children'),'MarkerSize',18);
set(get(gca,'Children'),'LineWidth',1.5);
if ~isempty(get(gca,'ZTickLabel'))
  set(get(gca,'Children'),'EdgeColor','interp','FaceColor','interp');
end
set(gca,'FontSize',8)
return

%%
% function handle=slvFigure(label)
% h=findobj;
% k=0;
% if length(h)>1
%     for i=2:length(h)
%         if strcmp(get(h(i),'Tag'),label)
%             k=i;
%             break;
%         end
%     end
% end
% if k==0
%     bdwidth = 5;                    % width of window side and bottom borders
%     topbdwidth = 30;                % width of window top border
%     set(0,'Units','pixels');        % Ensure root units are pixels
%     scnsize = get(0,'ScreenSize');  % get the size of the screen
% 
%     mode = 0;
%     switch mode
%         case 2
%             %Define position vector for full screen size
%             pvec  = scnsize;
%         case 1
%             %Define position vector for full screen size
%             pvec  = [bdwidth; bdwidth; scnsize(3)-2*bdwidth; scnsize(4)-(topbdwidth + bdwidth)];
%         otherwise
%             %Define position vector for figure centered on screen
%             pvec  = [scnsize(3)/4+bdwidth; scnsize(4)/4+bdwidth; scnsize(3)/2-2*bdwidth; scnsize(4)/2-(topbdwidth + bdwidth)];
%     end
%     handle=figure('Tag',label,'Name',label,'NumberTitle','off','Position',pvec); % Create Figure
%     %set(handle,'NumberTitle','off')
%     set(handle,'WindowStyle','docked') % dock figure on creation only
% else
%     handle=figure(h(k));                    % Recall Figure
% end
% return
