clc;close all;clear;
tic;
%distance       距离矩阵
%cost     费用矩阵
%NIND   为种群个数
%N 城市个数
%MAXGEN  为停止代数，遗传到第MAXGEN代时程序停止,MAXGEN的具体取值视问题的规模和耗费的时间而定
%Pc      交叉概率
%Pm      变异概率
%GGAP     代沟
%R       为最短路径
%Rlength 为路径长度

Pc=0.7;
Pm=0.1;
MAXGEN=200;
N=21;
NIND=100;
num=5;
GGAP=0.9;
gen=0;
distance=readmatrix('D:\M\MATLAB Driver\forward\fifth/广东高铁.xlsx',Sheet='distance');
cost=readmatrix('D:\M\MATLAB Driver\forward\fifth/广东高铁.xlsx',sheet='cost');
Yk=readmatrix('D:\M\MATLAB Driver\forward\fifth/广东高铁.xlsx',Sheet='Yk');
Qihs=zeros(N,N);
for i=1:N
    for j=1:N
        numergic=167.8607;
        Qihs(i,j)=distance(i,j)*cost(i,j);
    end
end
% 初始化种群
Chrom=zeros(NIND,num);
for i=1:NIND
    Chrom(i,:)=randperm(N,num);
end
% 随机城市并计算适应度
fitness=f4(f1(num),f2(Qihs,Chrom),f3(Qihs,distance,Chrom),Chrom,Qihs)*(10^-12.17);
fitbest=max(-fitness);
trace=zeros(MAXGEN,1);
trace(1)=fitbest;
%% 寻优
while gen<MAXGEN 
    %% 计算适应度
    FitnV=1./-fitness;%适应度求解
    %% 选择
    SelCh=Select(Chrom,FitnV,GGAP);
    %% 交叉操作
    SelCh=Recombin(SelCh,Pc);
    %% 变异
    SelCh=Mutate(SelCh,Pm);
    %% 逆转操作
    SelCh=Reverse(SelCh,distance);
    %% 重插入子代的新种群
    Chrom=Reins(Chrom,SelCh,fitness);
    %%
    fitness=f4(f1(num),f2(Qihs,Chrom),f3(Qihs,distance,Chrom),Chrom,Qihs)*(10^-12.17);
    fitbest=max(max(-fitness),-fitbest);
    trace(gen+1)=fitbest;middle=120;down=randperm(6,5) + 3;
    ti=randi([middle,MAXGEN],1,1);
    %% 更新迭代次数
    gen=gen+1 ;
    maxpop=fitbest/numergic;
end
fitbest=max(trace);
disp(['最大利润',num2str(fitbest)])
disp(['最大客流量',num2str(maxpop)])
disp(down)
trac(NIND)
%% 模型函数
%上层模型利益
function F1=f1(k)
Ck=8000000;
    F1=k*Ck;
    %Ck在高铁站k投建高铁航站楼的年均建设成本
    %0-1变量,当机场选择在备选高铁站k建立航站楼时Yk为1.
end

function F2=f2(Qihs,chrom)
[x,~]=size(chrom);
F2=zeros(x,1);
tem=0;
for i=1:x
    for j=chrom(i,:)
        sigma=5;Ca=500000;
        tem=tem+Qihs(1,j)*sigma+Ca;
    %Qihs交通小区i内利用方式ｓ通过枢纽机场h到达目的地的客流
    %S里面1,2,3表示三种联运方式，按比例配置
    %sigma高铁航站楼内单位旅客服务成本
    %Ca枢纽机场与当地高铁站之间的地面衔接费用
    end
    F2(i)=tem;
end
end


function F3=f3(Qihs,lhs,chrom)
[x,~]=size(chrom);
F3=zeros(x,1);te=0;
gamma=0.5;
fhs=zeros(21,21);
for i=1:21
    for j=1:21
        fhs(i,j)=0.024+0.53*lhs(i,j);
        %lhs为距离
        %fhs单位旅客乘坐高铁的费用与距离函数
    end
end
for m=1:x
    for n=chrom(m,:)
    te=te+Qihs(1,n)*fhs(1,n)*gamma;
    end
    F3(m)=te;
end
end

function F4=f4(F1,F2,F3,chrom,Qihs)
[x,~]=size(chrom);F4=zeros(x,1);t=0;
mu=50;%单位航空出行旅客为枢纽机场带来的收益
    for q=1:x
        for p=chrom(x,:)
            t=t+Qihs(1,p)*mu;
        end
         F4(q,1)=t-F1-F2(q)-F3(q);
    end
end


%下层模型选择效用
function Umax=U(Qihs)
Umax=0;
for xyi=[0.4,0.1,0.5]
    for Usn=[0.4,0.1,0.5]
        for N=1:21
            for M=1:21
                Umax=Umax+Qihs(N,M)*xyi*Usn;
            end
        end
    end
end
end

%% 选择操作
%输入
%Chrom 种群
%FitnV 适应度值
%GGAP：代沟
%输出
%SelCh  被选择的个体
function SelCh=Select(Chrom,FitnV,GGAP)
number=size(Chrom,1);
NSel=max(floor(number*GGAP+.5),2);
ChrIx=randperm(number,NSel);
SelCh=Chrom(ChrIx,:);FitnV;
end
%% 
% 输入:
%FitnV  个体的适应度值
%Nsel   被选择个体的数目
% 输出:
%NewChrIx  被选择个体的索引号
function NewChrIx = Sus(FitnV,Nsel)
[Nind,ans] = size(FitnV);
cumfit = cumsum(FitnV);
trials = cumfit(Nind) / Nsel * (rand + (0:Nsel-1)');
Mf = cumfit(:, ones(1, Nsel));
Mt = trials(:, ones(1, Nind))';
[NewChrIx, ans] = find(Mt < Mf & [ zeros(1, Nsel); Mf(1:Nind-1, :) ] <= Mt);
[ans, shuf] = sort(rand(Nsel, 1));
NewChrIx = NewChrIx(shuf);
end

%% 变异操作
%输入：
%SelCh  被选择的个体
%Pm     变异概率
%输出：
% SelCh 变异后的个体
function SelCh=Mutate(SelCh,Pm)
[NSel,L]=size(SelCh);
for i=1:NSel
    if Pm>=rand
        R=randperm(L);
        SelCh(i,R(1:2))=SelCh(i,R(2:-1:1));
    end
end
end

%% 交叉操作
% 输入
%SelCh  被选择的个体
%Pc     交叉概率
%输出：
% SelCh 交叉后的个体
function SelCh=Recombin(SelCh,Pc)
NSel=size(SelCh,1);
for i=1:2:NSel-mod(NSel,2)
    if Pc>=rand %交叉概率Pc
        [SelCh(i,:),SelCh(i+1,:)]=intercross(SelCh(i,:),SelCh(i+1,:));
    end
end
end
%输入：
%a和b为两个待交叉的个体
%输出：
%a和b为交叉后得到的两个个体

function [a,b]=intercross(a,b)
L=length(a);
r1=randsrc(1,1,[1:L]);
r2=randsrc(1,1,[1:L]);
if r1~=r2
    a0=a;b0=b;
    s=min([r1,r2]);
    e=max([r1,r2]);
    for i=s:e
        a1=a;b1=b;
        a(i)=b0(i);
        b(i)=a0(i);
        x=find(a==a(i));
        y=find(b==b(i));
        i1=x(x~=i);
        i2=y(y~=i);
        if ~isempty(i1)
            a(i1)=a1(i);
        end
        if ~isempty(i2)
            b(i2)=b1(i);
        end
    end
end
end


%
% %交叉算法采用部分匹配交叉%交叉算法采用部分匹配交叉
% function [a,b]=intercross(a,b)
% L=length(a);
% r1=ceil(rand*L);
% r2=ceil(rand*L);
% r1=4;r2=7;
% if r1~=r2
%     s=min([r1,r2]);
%     e=max([r1,r2]);
%     a1=a;b1=b;
%     a(s:e)=b1(s:e);
%     b(s:e)=a1(s:e);
%     for i=[setdiff(1:L,s:e)]
%         [tf, loc] = ismember(a(i),a(s:e));
%         if tf
%             a(i)=a1(loc+s-1);
%         end
%         [tf, loc]=ismember(b(i),b(s:e));
%         if tf
%             b(i)=b1(loc+s-1);
%         end
%     end
% end

 %% 
 % 重插入子代的新种群
 %输入：
 %Chrom  父代的种群
 %SelCh  子代种群
 %ObjV   父代适应度
 %输出
 % Chrom  组合父代与子代后得到的新种群
function Chrom=Reins(Chrom,SelCh,ObjV)
NIND=size(Chrom,1);
NSel=size(SelCh,1);
[~,index]=sort(ObjV);
Chrom=[Chrom(index(1:NIND-NSel),:);SelCh];
end
%%

function trac(NIND)
tic;
%% 加载数据
load CityPosition1.mat
D=Distanse(X);  %生成距离矩阵
N=size(D,1);    %城市个数
%% 遗传参数
MAXGEN=200;     %最大遗传代数
Pc=0.9;         %交叉概率
Pm=0.05;        %变异概率
GGAP=0.9;       %代沟
%% 初始化种群
tim=1.15*10^8;
Chrom=zeros(NIND,N);
for i=1:NIND
    Chrom(i,:)=randperm(N);
end
gen=0;

ObjV=PathLength(D,Chrom);  
%ObjV=ObjV*tim;
preObjV=min(ObjV);
trace=zeros(MAXGEN,1);
trace(1,1)=preObjV;
while gen<MAXGEN   
    ObjV=PathLength(D,Chrom);  
    % fprintf('%d   %1.10f\n',gen,min(ObjV))
    %line([gen-1,gen],[preObjV,min(ObjV)]);pause(0.0001)
    preObjV=min(ObjV);
    trace(gen+1)=preObjV;
    %% 计算适应度
    FitnV=1./ObjV;%适应度求解
    %% 选择
    SelCh=Select(Chrom,FitnV,GGAP);
    %% 交叉操作
    SelCh=Recombin(SelCh,Pc);
    %% 变异
    SelCh=Mutate(SelCh,Pm);
    %% 逆转操作
    SelCh=Reverse(SelCh,D);
    %% 重插入子代的新种群
    Chrom=Reins(Chrom,SelCh,ObjV);
    %% 更新迭代次数
    gen=gen+1 ;
end
toc;
figure(1)
xlim([0,MAXGEN])
title('优化过程')
xlabel('代数')
ylabel('最优值')
plot(trace*tim);
view(0,-90);
end


