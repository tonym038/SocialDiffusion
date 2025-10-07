function [FD] = SocDynK_6b(g,n,beta,r,k,s,rounds) 
FD=0;
n_s=sum(s)/n; 
if isscalar(s)
    s=[zeros(n-s,1); ones(s,1)]; 
end
if isscalar(k)
    k=ones(n,1)*k; 
end
if isscalar(r) 
    r=ones(n,1)*r;
end
if isscalar(beta)
    beta=ones(n,1)*beta;
end

if size(k,1)==1
    k=k';
end

if size(s,1)==1
    s=s';
end

if size(r,1)==1
    r=r';
end

if size(beta,1)==1
    beta=beta';
end

b=ones(n,1)-k-r;
old=zeros(n,1)+s; 
x=old;
p=.5; 
z=n*n_s;
FullDiffusion = false;
for rnds = 1:rounds
    if ~FullDiffusion
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
        a_all=a_base.*G;
        P_1=x'.*a_all;
        S_C_1=sum(P_1,2);
        P_0=(1-x').*a_all;
        S_C_0=sum(P_0,2);
        pi(:,1)=S_C_0+k.*(1-x)+r.*(1-p); 
        pi(:,2)=S_C_1+k.*x+r.*p; 
        x=zeros(n,1);
        x(rand(n,1)<exp(beta.*pi(:,2))./(exp(beta.*pi(:,2))+exp(beta.*pi(:,1))))=1;
        x(s==1)=1; 
        p=.5*(1+(sum(x)-x)/(n-1)-(sum(old)-old)/(n-1)); 
        z=[z sum(x)];
        if ~FullDiffusion 
            if sum(x)>=.99*n
                FullDiffusion=true;
                FD=1;
            end
        end
        old=x;
    end        
end
end