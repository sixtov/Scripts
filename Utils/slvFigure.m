function handle=slvFigure(varargin)
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
