clc
clear all
%tic;
n=1000;
R=200;
beta=7.8;
r_e=0.42;
r_f=0.16;
k_e=0.10;
k_f=0.42;
conf=0.15:0.005:0.30; %x-values
rho=0:.1:1; %y-values
M=length(rho);
N=length(conf);
count=zeros(M,N);
time=zeros(M,N);
for i=1:M
    display(strcat('Progress:',num2str(round((i-1)/M*100)),'%'))
    for j=1:N
        n_n=round(n*(1-conf(j)));
        n_e=round(n_n*rho(i));
        for k=1:R
            [temp_c,temp_t]=SocDynK_time_t(n,beta,[r_e*ones(1,n_e) r_f*ones(1,n_n-n_e)],[k_e*ones(1,n_e) k_f*ones(1,n_n-n_e)],n-n_n);
            count(i,j)=count(i,j)+temp_c; %=No. times full diffusion reached
            time(i,j)=time(i,j)+temp_c*temp_t; %=Total time for full diffusion
        end
    end
end
time=time./count; %=Average time for diffusion
count=count/R; %=Percentage of times full diffusion reached
%view
%surf(conf, rho, count)
%view(0, 90);
figure
surf(conf, rho, time) %plot function (x,y,z)
view(0, 90);
%toc

