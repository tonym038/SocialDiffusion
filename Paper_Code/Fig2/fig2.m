clc
clear all
n=200; %No. participants
beta=7.8; %Rationality
r_e=0.42; %Weights of mechanisms for explorers and non-explorers
r_f=0.16;
k_e=0.10;
k_f=0.42; 
%b is defined in the SocDynK function
rho=0.2; %Percentage of explorers
hold on
n_e=round(n*rho*3/4); %No. explorers = No.participants*percentage explorers*percentage non-committed
[t,dt,y]=SocDynK_time2(n,beta,[r_e*ones(1,n_e) r_f*ones(1,n-n_e)],[k_e*ones(1,n_e) k_f*ones(1,n-n_e)],n/4,rho); %Plots line where rho=0.2
rho=0.6;
hold on %Allows multiple lines for fig 2a
n_e=round(n*rho*3/4);
[t2,dt2,y2]=SocDynK_time2(n,beta,[r_e*ones(1,n_e) r_f*ones(1,n-n_e)],[k_e*ones(1,n_e) k_f*ones(1,n-n_e)],n/4,rho);
title('Original Fig2a')
xlabel('Round, t')
ylabel('Players Adopting the Alternative')
legend()
figure %Used to create new figure window
histogram(y/t,14,'Normalization','percentage','FaceColor','#ff9900','EdgeColor','#ff9900')
ytickformat("percentage")
title('Fig2b: Switching Rate \rho_{e} = 0.2')
xlabel('Switching rate, y')
ylabel('Percentage Frequency')
figure
histogram(y2/t2,14,'Normalization','probability','FaceColor','#0000CC','EdgeColor','#0000CC')
title('Fig2c: Switching Rate \rho_{e} = 0.6')
xlabel('Switching rate, y')
ylabel('Percentage Frequency')