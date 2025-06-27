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
for i=1:50 %Creates 50 simulations
[y,t]=SocDynK_time2(n,beta,[r_e*ones(1,n_e) r_f*ones(1,n-n_e)],[k_e*ones(1,n_e) k_f*ones(1,n-n_e)],n/4);
end
figure %Opens new figure window
histogram(y/t,15) %Paper changed y-axis scale

beta_h=19.7; %Changes the rationality for non-explorers for next fig
beta_l=4.8; %Changes the rationality for explorers for next fig
T=100000; %New maximum number of rounds for next fig


%% Heterogeneous
beta=[beta_l*ones(75,1);beta_h*ones(125,1)]; %Creates an array of betas
figure %Opens new figure window
hold on
for i=1:50 %Creates 50 simulations on same window
[a,b]=SocCoK(200,beta,T,1/4);
end
%plot(0:T,a);
figure
histogram(max(b,0),15) %Paper changed y-axis 



%% Heterogeneous diffusion 1
ex=105; %=No. of explorers (=70% as per paper)
T=120; %=Max number of rounds
beta=[beta_l*ones(ex,1);beta_h*ones(n-ex,1)]; %New beta matrix running vertically
figure
hold on
for i=1:50 %Creates 50 simulations
[a,b]=SocCoK(200,beta,T,1/4);
end
figure
histogram(max(b,0),15) %Paper changed y-axis scale

%% Heterogeneous diffusion 2
beta_h=8.5; %Changes rationality for non-explorers
T=120;
beta=[beta_l*ones(75,1);beta_h*ones(125,1)];
figure
hold on
for i=1:50
[a,b]=SocCoK(200,beta,T,1/4);
end
figure
histogram(max(b,0),15,'Normalization','probability')

