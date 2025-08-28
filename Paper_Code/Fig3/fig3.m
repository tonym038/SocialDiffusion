clear all
clc

%% Our
g=5;
n=200; %No. Participants
beta=7.8; %Rationality
r_e=0.42; %Coefficients for mechanisms explorers vs non-explorers
r_f=0.16;
k_e=0.1;
k_f=0.42; 
rho=0.5; %Percentage of explorers is 0.5 for this model
n_e=round(n*rho*3/4); % = No. explorers
rounds=120;
figure %Opens new figure window
hold on %Allows multiple lines on same plot
[t,dt,y]=SocDynK_time2(g,n,beta,[r_e*ones(1,n_e) r_f*ones(1,n-n_e)],[k_e*ones(1,n_e) k_f*ones(1,n-n_e)],n/4,rho,rounds);
title(['Fig3a: \gamma = ',num2str(g)])
xlabel('Round, t')
ylabel('Diffusion')
figure %Opens new figure window
histogram(max(0,y/t),15, 'Normalization','percentage','FaceColor','#4d0a8c','EdgeColor','#4d0a8c','BinWidth',0.03)
ytickformat('percentage')
xlim([0 0.45])
ylim([0 100])
xlabel('Switching Rate, y')
ylabel('Percentage Frequency')
title(['Fig 3b: Switching Rate \rho_{e} = 0.5, \gamma = ',num2str(g)])


%% Heterogeneous
g=8;
n=200;
rho=0.5;
beta_h=19.7; %Changes the rationality for non-explorers for next fig
beta_l=4.8; %Changes the rationality for explorers for next fig
beta=[beta_l*ones(75,1);beta_h*ones(125,1)]; %Creates an array of betas
r=0;
k=0;
n_e=round(n*rho*3/4); % = No. explorers
rounds=10000;
figure %Opens new figure window
hold on %Allows multiple lines on same plot
[t,dt,y]=SocDynK_time2(g,n,beta,r,k,n/4,rho,rounds);
title(['Fig3c: \gamma = ',num2str(g)])
xlabel('Round, t')
ylabel('Diffusion')
legend(Location="northeast")
ylim([0 100])
figure %Opens new figure window
histogram(max(0,y/t),15, 'Normalization','percentage','FaceColor','#4d0a8c','EdgeColor','#4d0a8c','BinWidth',0.03)
ytickformat('percentage')
xlim([0 0.45])
ylim([0 100])
xlabel('Switching Rate, y')
ylabel('Percentage Frequency')
title(['Fig 3d: Switching Rate \rho_{e} = 0.5, \gamma = ',num2str(g)])



%% Heterogeneous diffusion 1
g=1;
n=200;
rho=0.7;
beta_h=19.7; %Changes the rationality for non-explorers for next fig
beta_l=4.8; %Changes the rationality for explorers for next fig
beta=[beta_l*ones(75,1);beta_h*ones(125,1)]; %Creates an array of betas
r=0;
k=0;
n_e=round(n*rho*3/4); % = No. explorers
rounds=120;
figure %Opens new figure window
hold on %Allows multiple lines on same plot
[t,dt,y]=SocDynK_time2(g,n,beta,r,k,n/4,rho,rounds);
title(['Fig3e: \gamma = ',num2str(g)])
xlabel('Round, t')
ylabel('Diffusion')
legend(Location="northeast")
ylim([0 100])
figure %Opens new figure window
histogram(max(0,y/t),15, 'Normalization','percentage','FaceColor','#009933','EdgeColor','#009933','BinWidth',0.03)
ytickformat('percentage')
xlim([0 0.45])
ylim([0 100])
xlabel('Switching Rate, y')
ylabel('Percentage Frequency')
title(['Fig 3f: Switching Rate \rho_{e} = 0.7, \beta_{f} = ',num2str(beta_h),', \gamma = ',num2str(g)])

%% Heterogeneous diffusion 2
g=5;
n=200;
rho=0.7;
beta_h=8.5; %Changes the rationality for non-explorers for next fig
beta_l=4.8; %Changes the rationality for explorers for next fig
beta=[beta_l*ones(75,1);beta_h*ones(125,1)]; %Creates an array of betas
r=0;
k=0;
n_e=round(n*rho*3/4); % = No. explorers
rounds=120;
figure %Opens new figure window
hold on %Allows multiple lines on same plot
[t,dt,y]=SocDynK_time2(g,n,beta,r,k,n/4,rho,rounds);
title(['Fig3g: \gamma = ',num2str(g)])
xlabel('Round, t')
ylabel('Diffusion')
legend(Location="northeast")
ylim([0 100])
figure %Opens new figure window
histogram(max(0,y/t),15, 'Normalization','percentage','FaceColor','#009933','EdgeColor','#009933','BinWidth',0.03)
ytickformat('percentage')
xlim([0 0.45])
ylim([0 100])
xlabel('Switching Rate, y')
ylabel('Percentage Frequency')
title(['Fig 3h: Switching Rate \rho_{e} = 0.7, \beta_{f} = ',num2str(beta_h), ', \gamma = ',num2str(g)])

