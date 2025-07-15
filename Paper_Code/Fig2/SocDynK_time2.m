function [t,dt,y] = SocDynK_time2(n,beta,r,k,s,rho) 
%s is the number of committed minority
% k and r are arrays of n*1 where the first n-s entries are k_e, followed
% by k_f
n_s=sum(s)/n; %Defines the percentage of committed minority
if length(s)==1
    s=[zeros(n-s,1); ones(s,1)]; %Creates an nx1 array where the first (n-s) rows are 0, following s are 1
end
if length(k)==1
    k=ones(n,1)*k; %Creates an nx1 array where every value is k
end
if length(r)==1 %Creates an nx1 array where every value is r
    r=ones(n,1)*r;
    % The nature of k and r arrays will ensure each value adheres to
    % predefined coefficient for explorers and non-explorers
end

if size(k,1)==1
    k=k'; %Transposes the k array
end

if size(s,1)==1
    s=s';
end

if size(r,1)==1
    r=r';
end
b=ones(n,1)-k-r; %b is the remainder of weights from k and r
%From definition of b+k+r=1
g=1;
for runs=1:10
    y=zeros(n,1); %Creates an array of 0s (n rows, 1 column)
    old=zeros(n,1)+s; %Creates an nx1 array all of value s (Remembering the s parameter has been modified in code)
    x=old;
    p=.5; %Sets starting value for x_hat
    t=0; %Sets starting value for t
    flag=0;
    dt=0;
    z=n*n_s; %=Number of committed minority
    while flag==0 && t<600
        t=t+1;
        Total_equals=[];
        G=ones(n,n);
        for v=1:n
            equals=-1;
            for w=1:n
                if x(v)==x(w)
                    equals=equals+1;
                    G(v,w)=g;
                end
                if w==v
                    G(v,w)=0;
                end
            end
            Total_equals=[Total_equals; equals];
        end
        Total_unequals=n-1-Total_equals;
        a_base = b./(g*Total_equals + Total_unequals);
        denominator=(g*Total_equals + Total_unequals);
        a_all=a_base.*G;
        P_1=x'.*a_all;
        S_C_1=sum(P_1,2);
        P_0=(1-x').*a_all;
        S_C_0=sum(P_0,2);
        pi(:,1)=S_C_0+k.*(1-x)+r.*(1-p); %SQ (0)
        pi(:,2)=S_C_1+k.*x+r.*p; %Alt (1)
        x=zeros(n,1);
        x(rand(n,1)<exp(beta*pi(:,2))./(exp(beta*pi(:,2))+exp(beta*pi(:,1))))=1;
        %If rand number [0,1] < prob(alt), then agent plays alt
        x(s==1)=1; %Those who are CM will play strat 1 (alt)
        p=.5*(1+(sum(x)-x)/(n-1)-(sum(old)-old)/(n-1)); %Updates x_hat
        z=[z sum(x)];
        if sum(x)<=.4*n
            dt=t; %dt will stop at take-off time
        end
        y=y+abs(old-x); %adds 1 to any element of y whose agent has switched
        old=x; %Updates t-1 (Useful for x_hat)
    end
    dt=t-dt; %dt becomes a measure of explosiveness
    y=y(1:round((1-n_s)*n))'-1; %Formula for switching rate (Not divided by diffusion time)
    if t>400
        z=reducev(z,0:t,200);
    end
    if rho == 0.6
        if runs < 10
            plot(linspace(0,t,length(z)),(z-n_s*n)/(n-n_s*n),'color','#cce0ff')
        end
        if runs == 10
            plot(linspace(0,t,length(z)),(z-n_s*n)/(n-n_s*n),'color','#0000CC')
        end
    end
    if rho == 0.2
        if runs < 10
            plot(linspace(0,t,length(z)),(z-n_s*n)/(n-n_s*n),'color','#ffd699')
        end
        if runs == 10
            plot(linspace(0,t,length(z)),(z-n_s*n)/(n-n_s*n),'color','#ff9900')
        end
    end
    end
end