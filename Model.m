function OUT = Model(IN)
% A is the adjacency matrix, x0 the initial condition, weight of the consistency dynamics k, weight
%of the prediction dynamics r, weight of the coordination dynamics, total number of rounds T, and s
%is a vector of dimension n with 1 in correspondence of the stubborn nodes
%or an integer number with the number of stubborn nodes (automatically
%placed in a the last s nodes). If flag is st to 'y', then the output includes the
%state of the stubborn nodes. Otherwise, the flag variable can be omitted.

% IN = struct('n', n, 'n_e', n_e, 'n_z', n_z, 'beta', beta, 'r_e', r_e, 'r_f', r_f, 'k_e', k_e, 'k_f', k_f, 'T', T, 'alpha', alpha);
OUT = struct();

r = [IN.r_e*ones(1,IN.n_e) IN.r_f*ones(1,IN.n-IN.n_e)]; % explorers, non-explorers, zealots. Zealot states are fixed, so properties don't matter
k = [IN.k_e*ones(1,IN.n_e) IN.k_f*ones(1,IN.n-IN.n_e)];

if length(IN.n_z)==1
    IN.n_z=[zeros(IN.n-IN.n_z,1); ones(IN.n_z,1)];
end
if length(k)==1
    k=ones(IN.n,1)*k;
end
if length(r)==1
    r=ones(IN.n,1)*r;
end

if size(k,1)==1
    k=k';
end

if size(IN.n_z,1)==1
    IN.n_z=IN.n_z';
end

if size(r,1)==1
    r=r';
end
b=ones(IN.n,1)-k-r;

old=zeros(IN.n,1)+IN.n_z;
y=zeros(IN.n,IN.T);
x=old;
y(:,1)=x;
p=.5;
t=1;
z=sum(x);
while t<IN.T 
    t=t+1;
    pi(:,1)=b*sum(1-x)/(IN.n-1)+(k-b/(IN.n-1)).*(1-x)+r.*(1-p);
    pi(:,2)=(b*sum(x)/(IN.n-1)+(k-b/(IN.n-1)).*x+r.*p) * (1+IN.alpha);
    x=zeros(IN.n,1);
    x(rand(IN.n,1)<exp(IN.beta*pi(:,2))./(exp(IN.beta*pi(:,2))+exp(IN.beta*pi(:,1))))=1;
    x(IN.n_z==1)=1;
    p=.5*(1+(sum(x)-x)/(IN.n-1)-(sum(old)-old)/(IN.n-1));
    z=[z sum(x)];
    old=x;
    y(:,t)=old;
end

OUT.x = y;

end