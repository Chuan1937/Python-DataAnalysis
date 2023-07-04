tic;
%% 加载数据
load CityPosition1.mat
D=Distanse(X);  %生成距离矩阵
N=size(D,1);    %城市个数
%% 遗传参数
NIND=100;       %种群大小
MAXGEN=200;     %最大遗传代数
Pc=0.9;         %交叉概率
Pm=0.05;        %变异概率
GGAP=0.9;       %代沟
%% 初始化种群
Chrom=zeros(NIND,N);
for i=1:NIND
    Chrom(i,:)=randperm(N);
end
%% 优化
gen=0;
figure;
hold on;box on
xlim([0,MAXGEN])
title('优化过程')
xlabel('代数')
ylabel('最优值')
ObjV=PathLength(D,Chrom);  
preObjV=min(ObjV);
while gen<MAXGEN   
    ObjV=PathLength(D,Chrom);  
    % fprintf('%d   %1.10f\n',gen,min(ObjV))
    line([gen-1,gen],[preObjV,min(ObjV)]);pause(0.0001)
    preObjV=min(ObjV);
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



