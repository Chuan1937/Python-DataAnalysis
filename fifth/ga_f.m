function [BESTX,BESTY,ALLX,ALLY]=ga_f(KU,KD,NU,ND,PmU,PmD,V,Q,R,m,t,p0,CF,Alpha,Beta,C0,Q0,h,a,b,d,Cr)
%% 输入参数列表

% KU      上层迭代次数

% KD      下层迭代次数

% NU      上层种群规模，要求是偶数

% ND      下层种群规模，要求是偶数

% PmU      上层变异概率

% PmD      下层变异概率

% 其余参数均为模型参数

%% 输出参数列表

% xbest    下层模型的最优决策变量

% BESTX    K×1细胞结构，每一个元素是M×1向量，记录每一代的最优个体

% BESTY    K×1矩阵，记录每一代的最优个体的评价函数值

% ALLX    K×1细胞结构，每一个元素是M×N矩阵，记录全部个体

% ALLY    K×N矩阵，记录全部个体的评价函数值

%% 第一步：种群初始化，确保满足约
n=length(C0);%决策变量的个数
%种群初始化，每一行是一个样本
farm=zeros(NU,n);
for i=1:NU
Ta=randperm(n);
Tb=unidrnd(n-1)+1;
farm(i,sort(Ta(1:Tb)))=1;
GT=farm(i,:);
GT=JZU(GT,V,Q);
farm(i,:)=GT;
end
%输出变量初始化
ALLX=cell(KU,1);%细胞结构，每一个元素是N×n矩阵，记录每一代的个体
ALLY=zeros(KU,NU);%K×N矩阵，记录每一代评价函数值
BESTX=cell(KU,1);%细胞结构，每一个元素是1×n向量，记录每一代的最优个体
BESTY=zeros(KU,1);%K×1矩阵，记录每一代的最优个体的评价函数值
k=1;%迭代计数器初始化

%% 第二步：迭代过程
while k<=KU
%% 以下是交叉过程
    newfarm=zeros(2*NU,n);
    Ser=randperm(NU);%两两随机配对的配对表
    AA=farm(Ser(1),:);
    BB=farm(Ser(2),:);
    P0=unidrnd(n-1);
    aa=[AA(1:P0),BB((P0+1):end)];%产生子代a

    bb=[BB(1:P0),AA((P0+1):end)];%产生子代b
    if sum(aa)<2
        Ta=randperm(n);
        Tb=unidrnd(n-1)+1;
        aa=zeros(1,n);
        aa(1,sort(Ta(1:Tb)))=1;
    end
    if sum(bb)<2
        Ta=randperm(n);
        Tb=unidrnd(n-1)+1;

        bb=zeros(1,n);
        bb(1,sort(Ta(1:Tb)))=1;
    end
    aa=JZU(aa,V,Q);
    bb=JZU(bb,V,Q);
    newfarm(2*NU-1,:)=aa;%加入子代种群
    newfarm(2*NU,:)=bb;
   
    for i=1:(NU-1)
        AA=farm(Ser(i),:);

   BB=farm(Ser(i+1),:);
        P0=unidrnd(n-1);
        aa=[AA(1:P0),BB((P0+1):end)];
        bb=[BB(1:P0),AA((P0+1):end)];
        if sum(aa)<2
            Ta=randperm(n);
            Tb=unidrnd(n-1)+1;
            aa=zeros(1,n);
            aa(1,sort(Ta(1:Tb)))=1;
        end
        if sum(bb)<2

            Ta=randperm(n);
            Tb=unidrnd(n-1)+1;
            bb=zeros(1,n);
            bb(1,sort(Ta(1:Tb)))=1;
        end
        aa=JZU(aa,V,Q);
        bb=JZU(bb,V,Q);
        newfarm(2*i-1,:)=aa;
        newfarm(2*i,:)=bb;
    end   
    FARM=[farm;newfarm];

   
%% 选择复制
    SER=randperm(3*NU);
    FITNESS=zeros(1,3*NU);
    fitness=zeros(1,NU);
    for i=1:(3*NU)
        u=FARM(i,:);
        [xbest,BESTXx,BESTYy,ALLXx,ALLYy]=GAD(u,KD,ND,PmD,V,Q,R,m,t,p0,CF);
        %调用下层遗传算法得到x
        x=xbest;
        FITNESS(i)=OBJU(x,u,Alpha,Beta,C0,Q0,h,a,b,d,Q,Cr,m,t);
    end   
    for i=1:NU
        f1=FITNESS(SER(3*i-2));
        f2=FITNESS(SER(3*i-1));
        f3=FITNESS(SER(3*i));
        if f1<=f2&&f1<=f3
            farm(i,:)=FARM(SER(3*i-2),:);
            fitness(i)=FITNESS(SER(3*i-2));

        elseif f2<=f1&&f2<=f3
            farm(i,:)=FARM(SER(3*i-1),:);
            fitness(i)=FITNESS(SER(3*i-1));
        else
            farm(i,:)=FARM(SER(3*i),:);
            fitness(i)=FITNESS(SER(3*i));
        end
    end
   
    %% 记录最佳个体和收敛曲线
    X=farm;
    Y=fitness;
    ALLX{k}=X;
    ALLY(k,:)=Y;
    minY=min(Y);
    pos=find(Y==minY);
    BESTX{k}=X(pos(1),:);
    BESTY(k)=minY;
   
    %% 变异
    for i=1:NU
        if PmU>rand&&pos(1)~=i

            Ta=randperm(n);
            Tb=unidrnd(n-1)+1;
            BB=zeros(1,n);
            BB(1,sort(Ta(1:Tb)))=1;
            BB=JZU(BB,V,Q);
            farm(i,:)=BB;
        end
    end
    disp(k);
    k=k+1;
end

%% 绘图
BESTY2=BESTY;
BESTX2=BESTX;
for k=1:KU
    TempY=BESTY(1:k);
    minTempY=min(TempY);
    posY=find(TempY==minTempY);
    BESTY2(k)=minTempY;
    BESTX2{k}=BESTX{posY(1)};
end
BESTY=BESTY2;

BESTX=BESTX2;
plot(BESTY,'-ko','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',2)
ylabel('函数值')
xlabel('迭代次数')
grid on