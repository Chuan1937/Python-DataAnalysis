clear;clc;close;
data=readmatrix("湖北省累计确诊_隔离_恢复人数.xlsx");
time=datenum(data(:,1));qz=data(:,2);gl=data(:,3);
hf=data(:,4);
plot(time,qz)
datetick("x","mm/dd")
hold on
plot(time,gl)
plot(time,hf)
legend('确诊','隔离','恢复')
grid on
hold off

%%
beta1=(1:4/100:5);
alpha1=(0.95:0.04/100:0.99);
phi1=(0:1/100:1);
tau1=(0.06:0.24/100:0.3);
iter=1;ger=100;pbest=zeros(ger,4);ferror=zeros(ger,1);
miu=0.00752;sigma=0.00718;gamma1=0.6;
gamma2=0.5;omega=0.023;
while iter<ger
    imax=ger-iter;
    beta=beta1(randi([1,imax],1,1));
    alpha=alpha1(randi([1,imax],1,1));
    phi=phi1(randi([1,imax],1,1));
    tau=tau1(randi([1,imax],1,1));
    pbest(iter,1)=beta;pbest(iter,2)=alpha;
    pbest(iter,3)=phi;pbest(iter,4)=tau;
    %gamma1*x(2)+gamma2*x(3)-sigma*x(4)
    f=@(t,x)[miu-beta*(1-tau)*x(1)*x(2)-sigma*x(1);
    beta*(1-tau)*x(1)*x(2)-(gamma1+alpha+omega+sigma)*x(2);
    alpha*x(2)+phi*x(1)-(gamma2+omega+sigma)*x(3)];

    xt0=[59269171,375,426];
    
    [tspan,a] = ode45(f,[0 1/100000],xt0);
    tempp=0;temp=0;
    a=mapminmax(a,0,1);
    qz=mapminmax(qz,0,1);
    for i=1:70
       temp=(a(i,2)-qz(i)).^2;
       tempp=tempp+temp;
    end

    ferror(iter)=tempp;

    beta1(randi([1,imax],1,1))=[];
    alpha1(randi([1,imax],1,1))=[];
    phi1(randi([1,imax],1,1))=[];
    tau1(randi([1,imax],1,1))=[];

    iter=iter+1;
end
ferror(end)=[];
[in,t]=min(ferror);
disp(['beta:',num2str(pbest(t,1))])
disp(['alpha:',num2str(pbest(t,2))])
disp(['phi:',num2str(pbest(t,3))])
disp(['tau:',num2str(pbest(t,4))])
%%
beta=pbest(t,1);
alpha=pbest(t,2);
phi=pbest(t,3);
tau=pbest(t,4);
 f=@(t,x)[miu-beta*(1-tau)*x(1)*x(2)-sigma*x(1);
    beta*(1-tau)*x(1)*x(2)-(gamma1+alpha+omega+sigma)*x(2);
    alpha*x(2)+phi*x(1)-(gamma2+omega+sigma)*x(3)];

    xt0=[59269171,375,426];
    
    [tspan,a] = ode45(f,[0 1/100000],xt0);
next=a(1:70,2);
qz=mapminmax(qz',300,70000);
data_qz=mapminmax(next',300,70000);


figure
t=plot(time,qz)

hold on
y=plot(time,data_qz)
legend('原始','拟合')
grid on
set(gca,'GridAlpha',0.3);

x = get(t,'xdata');    
y = get(t,'ydata');    
x_new = x + 25;    
set(t,'xdata',x_new);    
set(t,'ydata',y);
datetick("x","mm/dd")
hold off


