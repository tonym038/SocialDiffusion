% close all
% clear variables

setup(); 
% rng(1); % fixing seed for testing purposes

    %% Input Parameter
% Agent Parameters
alpha=0; % relative (additive) advantage
beta=7.8; %6;
b_e = 0.48; % social coordination of explorers
k_e=0.10; %0.08; % inertia of explorers
r_e=0.42; %0.4; % trend-seeking of explorers
b_f = 0.42 - 0.1;
k_f=0.42+0.2; %0.32;
r_f=0.16 - 0.1; %0.135; 

% Population Parameters
n=30;
A=ones(n); % network. Currently hard-coded in model
rho=0.5; %0.35; target fraction of explorers among explorers & non-explorers
zel=0.22; %20/30; % target fraction of innovators / zealots / stubborn agents
n_z = round(n * zel); % actual number of zealots
n_e = round(rho*(n-n_z)); % actual number of explorers
n_f = n - n_e - n_z; % actual number of non-explorers

% Simulation Parameters
T=1000;

% Plot Parameters
T_gif = 150;  % Time step to finish on for gif
filename_gif = ''; % '' to suppress gif creation. 'Example_NetSci_Explosive.gif';

    %% Model Run
r = [r_e*ones(1,n_e) r_f*ones(1,n-n_e)]; % explorers, non-explorers, zealots. Zealot states are fixed, so properties don't matter
k = [k_e*ones(1,n_e) k_f*ones(1,n-n_e)];

% x = Model(n, beta, r, k, n_z, T, alpha);
IN = struct('n', n, 'n_e', n_e, 'n_z', n_z, 'beta', beta, 'r_e', r_e, 'r_f', r_f, 'k_e', k_e, 'k_f', k_f, 'T', T, 'alpha', alpha);
OUT = Model(IN);
x = OUT.x;

    %% Post-Simulation Analysis
% n = size(x,1);
t_f = size(x,2); % in case simulation terminated early
x_hat_colour = zeros(3,t_f,n); %First entry is colour, second is time step, third is person;

x_avg = mean(x);
fprintf('Complete adoption at t=%d\n', find(x_avg == 1,1));
for t = 1:t_f
    for i = 1:n
        if x(i,t) == 1
            % Set the marker colours to red if action is 1
            x_hat_colour(:,t:t_f,i) = repmat([1 0 0]',1,t_f-t+1);
        else
            %Set the marker colour to blue if action is 0
            x_hat_colour(:,t:t_f,i) = repmat([0 0 1]',1,t_f-t+1);
        end                
    end
end


    %% Plotting
gph = graph(A-eye(size(A,1)));
T_gif = min(T_gif, t_f); % in case simulation terminated early
    
figure_set = findobj('type','figure');    
fig1 = figure(1);
if ~isempty(figure_set) && ismember(1, [figure_set.Number]) % if exists, no need to adjust size and position
    clf(fig1);    
else
    set(fig1, 'Units', 'Normalized', 'OuterPosition', [0.1, 0.1, 0.7, 0.7]);
end
set(fig1, 'Renderer','painters','Color',[1 1 1])
set(axes,'YColor','none','XColor','none')
hold on

sp1 = subplot(1,2,1);
hold on;
plot1 = plot(1,x_avg(1),'LineWidth',4,'Color','r');
set(sp1,'YLim', [0 1],'XLim', [0 T_gif],'FontSize',24);
xlabel('Time Step','FontSize',24)
ylabel('Fraction Adopting Innovation')
hold off;

sp2 = subplot(1,2,2);
hold on;
plot2 = plot(gph,'LayOut','auto','NodeLabel',{});   %Displays public action
plot2.MarkerSize = 25;
plot2.EdgeAlpha = 0.05;
highlight(plot2, 0+(1:n_e),'Marker','o'); % explorers
highlight(plot2, n_e+(1:n_f),'Marker','^'); % non-explorers
highlight(plot2, n_e+n_f+(1:n_z),'Marker','X'); % zealots
set(sp2,'YColor','none','XColor','none')
dim = [0.85 0.6 0.6 0.3];
str = {'Time step',num2str(1)};
zz = annotation('textbox',dim,'String',str,'FitBoxToText','on');
set(zz,'EdgeColor',[1 1 1],'FontSize',24)
subtitle('O: Explorer, \Delta: Non-explorer, X: Zealot \newline Blue: Status Quo, Red: Alternative')
hold off;

if ~isempty(filename_gif)
    mov.gif_length = T_gif/2;
    mov.fps = round(T_gif/mov.gif_length);
    M = getframe; % initialize object; will be overwritten in loop
end

for t = 1:T_gif
    fig1;
    set(plot1,'XData',1:t,'YData',x_avg(1:t))
    mk_colour_public = reshape(x_hat_colour(:,t,:),3,n)'; %This takes out the marker colours for n individuals at the i-th time step, with i-th row being the marker colour for individual i
    plot2.NodeColor = mk_colour_public;   %Update marker colour representing public opinion        

    str = {'Time step',num2str(t)};
    zz.String = str;
    drawnow
    
    if ~isempty(filename_gif)
        M(t)=getframe(fig1);   %Captures the figure as a movie frame
        
        %Turn movie frame into an image
        im = frame2im(M(t));
        [imind,cm] = rgb2ind(im,256);
        
        %Write to GIF File
        if t == 1
            imwrite(imind,cm,filename_gif,'gif', 'Loopcount',inf,'DelayTime',1/mov.fps);
        else
            imwrite(imind,cm,filename_gif,'gif','WriteMode','append','DelayTime',1/mov.fps);
        end
    end
end