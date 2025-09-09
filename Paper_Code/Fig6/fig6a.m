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
Repeats=10;
Progress=1;
Rho_FD=nan(size(range_g));
tracker=0;
for g_range=range_g
    tracker=tracker+1;
    fprintf('Completing Scneario %d out of %d \n', tracker, numel(range_g))
    Avg_diffusion=false;
    for rh=range_rh 
       n_e=round(n*rh*3/4);
       if Avg_diffusion==false
           Diffusion=zeros(1,Repeats);
           for rep=1:Repeats
               rng(rep)
               [FD]=SocDynK_6a(g_range,n,beta,[r_e*ones(1,n_e) r_f*ones(1,n-n_e)],[k_e*ones(1,n_e) k_f*ones(1,n-n_e)],n/4,rounds);
               Diffusion(1,rep)=FD;
           end
           if mean(Diffusion) >= 0.7
               Avg_diffusion=true;
               Rho_FD(tracker)=rh;
               range_rh=range_rh(range_rh>=rh);
           end
       end
       Progress=Progress+1;
    end
end
plot(range_g,Rho_FD,'-o','MarkerSize',6)
grid on
title('Minimum \rho_{e} for Full Diffusion to Occur given \gamma')
xlabel('\gamma')
ylabel('\rho_{e} to the nearest 0.1')
xlim([0 g_max])
ylim([0 1])



