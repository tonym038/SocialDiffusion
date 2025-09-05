clc
clear all

n=200; 
beta=7.8;
r_e=0.42;
r_f=0.16;
k_e=0.10;
k_f=0.42;
rounds=450;

g_min=1;
g_max=20;
g_frequency=20;
rho_frequency=11;
range_g=linspace(g_min,g_max,g_frequency);
range_rh=linspace(0,1,rho_frequency);
WCS=size(range_g,2).*size(range_rh,2);
Repeats=10;
Progress=1;
Rho_FD=zeros(size(range_g));
while Progress <= WCS
    tracker=0;
    for g_range=range_g
        tracker=tracker+1;
        Avg_diffusion=false;
        for rh=range_rh
           disp(sprintf('Completing Scneario %d out of %d', Progress, WCS))
           n_e=round(n*rh*3/4);
           if Avg_diffusion==false
               Diffusion=zeros(1,Repeats);
               for rep=1:Repeats
                   [FD]=SocDynK_time2(g_range,n,beta,[r_e*ones(1,n_e) r_f*ones(1,n-n_e)],[k_e*ones(1,n_e) k_f*ones(1,n-n_e)],n/4,rounds);
                   Diffusion(1,rep)=FD;
               end
               if mean(Diffusion) >= 0.7
                   Avg_diffusion=true;
                   Rho_FD(tracker)=rh;
               else
                   Rho_FD(tracker)=NaN;
               end
           end
           Progress=Progress+1;
        end
    end
end
plot(range_g,Rho_FD,'-o','MarkerSize',6)
title('Minimum \rho_{e} for Full Diffusion to Occur given \gamma')
xlabel('\gamma')
ylabel('\rho_{e}')
xlim([g_min g_max])
ylim([0 1])



