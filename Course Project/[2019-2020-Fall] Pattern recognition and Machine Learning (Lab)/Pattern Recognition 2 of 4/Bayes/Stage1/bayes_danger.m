function [ra1_x,ra2_x,result]=bayes_danger(x,pw1,pw2)
m=size(x,2)
ra1_x=zeros(1,m)
ra2_x=zeros(1,m)
result=zeros(1,m)
for ki=1:m
    ra1_x(ki)=4*(pw2*normpdf(x(ki),2,2))/(pw1*normpdf(x(ki),-2,0.5)+pw2*normpdf(x(ki),2,2))
    ra2_x(ki)=2*(pw1*normpdf(x(ki),-2,0.5))/(pw1*normpdf(x(ki),-2,0.5)+pw2*normpdf(x(ki),2,2))
end

for ki=1:m
    if ra2_x(ki)>ra1_x(ki)
        result(ki)=1
    else
        result(ki)=2
    end 
end

a=[-5:0.1:5]
n=size(a,2)
ra1_x_plot=zeros(1,n)
ra2_x_plot=zeros(1,n)
for kj=1:n
    ra1_x_plot(kj)=4*(pw2*normpdf(a(kj),2,2))/(pw1*normpdf(a(kj),-2,0.5)+pw2*normpdf(a(kj),2,2))
    ra2_x_plot(kj)=2*(pw1*normpdf(a(kj),-2,0.5))/(pw1*normpdf(a(kj),-2,0.5)+pw2*normpdf(a(kj),2,2))
end

figure(1)
hold on
plot(a,ra1_x_plot,'b-',a,ra2_x_plot,'g*-')
for k=1:m
    if result(k)==1
        plot(x(k),-0.1,'b*')
    else plot(x(k),-0.1,'go')
    end;
end;
xlabel('X')
ylabel('R')
title('·çÏÕÅÐ¾öÇúÏß')
return
