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
g_frequency=39;
rho_frequency=21;
CM_min=0.15;
CM_max=0.3;
CM_frequency=31;
range_g=linspace(g_min,g_max,g_frequency);
range_rh=linspace(0,1,rho_frequency);
%original_range_rh=range_rh;
range_CM=linspace(CM_min,CM_max,CM_frequency);
Repeats=7;
Rho_FD=nan(numel(range_CM),numel(range_g));
tracker=0;
CM_iteration=0;
for CM_range=1:numel(range_CM)
    CM=round(n*range_CM(CM_range));
    tracker=tracker+1;
    fprintf('Completing Scneario %d out of %d \n', tracker, numel(range_CM))
    parfor g_range=1:numel(range_g)
        Avg_diffusion=false;
        for rh=range_rh 
           n_e=round(n*rh*3/4);
           if Avg_diffusion==false
               Diffusion=zeros(1,Repeats);
               for rep=1:Repeats
                   rng(rep)
                   [FD]=SocDynK_6b(range_g(g_range),n,beta,[r_e*ones(1,n_e) r_f*ones(1,n-n_e)],[k_e*ones(1,n_e) k_f*ones(1,n-n_e)],CM,rounds);
                   Diffusion(1,rep)=FD;
               end
               if mean(Diffusion) >= 0.7
                   Avg_diffusion=true;
                   Rho_FD(CM_range,g_range)=rh;
                   %range_rh=range_rh(range_rh>=rh);
               end
           end
        end
    end
end
%% Surf and View
surf(range_g,range_CM,Rho_FD)
grid on
title('Minimum* \rho_{e} for Full Diffusion to Occur given \gamma and CM',FontSize=14)
xlabel({'\gamma';'*At least 70% of scenarios reaching full diffusion in 450 rounds'},'FontSize',13)
ylabel('Proportion of Commited Minority (CM)','FontSize',13)
xlim([0 g_max])
view(0,90)
c=colorbar;
c.Label.String='\rho_{e}';
c.Label.Rotation=0;
c.FontSize=13;
colormap('sky')

%% Contourf
contourf(range_g, range_CM,Rho_FD)
title('Minimum* \rho_{e} for Full Diffusion to Occur given \gamma and CM',FontSize=14)
xlabel({'\gamma';'*At least 70% of scenarios reaching full diffusion in 450 rounds'},'FontSize',13)
ylabel('Proportion of Commited Minority (CM)','FontSize',13)
xlim([0 g_max])
c=colorbar;
c.Label.String='\rho_{e}';
c.Label.Rotation=0;
c.FontSize=13;
colormap('sky')