g=1.5;
Total_equals=[];
n=11;
old=[0;0;0;0;0;0;0;0;1;1;1];
x=old;
G=ones(n,n);
for v=1:n
    equals=-1;
    for w=1:n
        if old(v)==old(w)
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
%G=[0 1 g 1; 1 0 1 1; 1 g 0 1; g g 1 0];
b=[1;2;3;20;5;6;7;8;9;30;11];
a_base  = b./(g*Total_equals + Total_unequals);
%a_base=[1 2 3 4];
denominator=(g*Total_equals + Total_unequals);
a_all=a_base.*G;
P_1=x'.*a_all;
S_C_1=sum(P_1,2);
P_0=(1-x').*a_all;
S_C_0=sum(P_0,2);