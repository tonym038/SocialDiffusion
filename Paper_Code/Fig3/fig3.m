clear all
clc

%% Our
n=200; %No. Participants
beta=7.8; %Rationality
r_e=0.42; %Coefficients for mechanisms explorers vs non-explorers
r_f=0.16;
k_e=0.1;
k_f=0.42; 
rho=0.5; %Percentage of explorers is 0.5 for this model
n_e=round(n*rho*3/4); % = No. explorers
figure %Opens new figure window
hold on %Allows multiple lines on same plot
[t,dt,y]=SocDynK_time2(n,beta,[r_e*ones(1,n_e) r_f*ones(1,n-n_e)],[k_e*ones(1,n_e) k_f*ones(1,n-n_e)],n/4,rho);
title('Modified Fig3a: \gamma = 5')
xlabel('Round, t')
ylabel('Diffusion')
figure %Opens new figure window
histogram(max(0,y/t),15, 'Normalization','percentage','FaceColor','#4d0a8c','EdgeColor','#4d0a8c','BinWidth',0.03)
ytickformat('percentage')
xlim([0 0.45])
ylim([0 100])
xlabel('Switching Rate, y')
ylabel('Percentage Frequency')
title('Modified Fig 3b: Switching Rate \rho_{e} = 0.5, \gamma = 5')


%% Heterogeneous
beta_h=19.7; %Changes the rationality for non-explorers for next fig
beta_l=4.8; %Changes the rationality for explorers for next fig
rounds=100000; %New maximum number of rounds for next fig
r_e=0.42; %Coefficients for mechanisms explorers vs non-explorers
r_f=0.16;
k_e=0.1;
k_f=0.42; 
rho=0.5; %Percentage of explorers is 0.5 for this model
beta=[beta_l*ones(75,1);beta_h*ones(125,1)]; %Creates an array of betas
figure %Opens new figure window
hold on
[a,b]=SocCoK(200,beta,rounds,1/4);
%plot(0:T,a);
figure
histogram(max(0,b),15) %Paper changed y-axis 



%% Heterogeneous diffusion 1
ex=105; %=No. of explorers (=70% as per paper)
T=120; %=Max number of rounds
beta=[beta_l*ones(ex,1);beta_h*ones(n-ex,1)]; %New beta matrix running vertically
figure
hold on
[a,b]=SocCoK(200,beta,T,1/4);
figure
histogram(max(0,b),15) %Paper changed y-axis scale

%% Heterogeneous diffusion 2
beta_h=8.5; %Changes rationality for non-explorers
T=120;
beta=[beta_l*ones(75,1);beta_h*ones(125,1)];
figure
hold on
[a,b]=SocCoK(200,beta,T,1/4);
figure
histogram(max(0,b),15,'Normalization','probability')

