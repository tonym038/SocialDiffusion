clc
clear all
g=1;
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
[t,dt,y,x,dydx]=SocDynK_time2(g,n,beta,[r_e*ones(1,n_e) r_f*ones(1,n-n_e)],[k_e*ones(1,n_e) k_f*ones(1,n-n_e)],n/4,rho); %Plots line where rho=0.2
rho=0.6;
hold on %Allows multiple lines for fig 2a
n_e=round(n*rho*3/4);
[t2,dt2,y2,x2,dydx2]=SocDynK_time2(g,n,beta,[r_e*ones(1,n_e) r_f*ones(1,n-n_e)],[k_e*ones(1,n_e) k_f*ones(1,n-n_e)],n/4,rho);
title(['Fig2a: \gamma = ',num2str(g)])
xlabel('Round, t')
ylabel('Players Adopting the Alternative')
legend(Location="southeast")
figure %Used to create new figure window
plot(x,dydx,'color','#b03509',DisplayName='\rho_{e} = 0.2')
ytickformat("percentage")
hold on
plot(x2,dydx2,'color','#0000CC',DisplayName='\rho_{e} = 0.6')
title(['Fig 2d: \gamma = ',num2str(g)])
xlabel('Round, t')
ylabel({'Percentage Point Players Adopting the Alternative' ;'Backwards Rolling Average of Last 10 Rounds'})
legend(Location='northeast')
figure
histogram(max(0,y/t),14,'Normalization','percentage','FaceColor','#b03509','EdgeColor','#b03509', 'BinWidth', 0.025)
ytickformat("percentage")
xlim([0 0.35])
ylim([0 100])
title(['Fig2b: Switching Rate \rho_{e} = 0.2, \gamma = ',num2str(g)])
xlabel('Switching rate, y')
ylabel('Percentage Frequency')
figure
histogram(max(0,y2/t2),14,'Normalization','percentage','FaceColor','#0000CC','EdgeColor','#0000CC','BinWidth', 0.025)
ytickformat("percentage")
xlim([0 0.35])
ylim([0 100])
title(['Fig2c: Switching Rate \rho_{e} = 0.6, \gamma = ',num2str(g)])
xlabel('Switching rate, y')
ylabel('Percentage Frequency')