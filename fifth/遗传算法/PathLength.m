%% 计算各个体的路径长度
% 输入：
% D     两两城市之间的距离
% Chrom 个体的轨迹
function len=PathLength(D,Chrom)
[~,col]=size(D);
NIND=size(Chrom,1);
len=zeros(NIND,1);
%此方法原理为每个染色体中的片段代表一组路线
for i=1:NIND
    p=[Chrom(i,:) Chrom(i,1)];%构造路径回路行向量 
    i1=p(1:end-1);
    i2=p(2:end);
    len(i,1)=sum(D((i1-1)*col+i2));
    %此处(i1-1)*col+i2表示求D矩阵的列标
    %此处D的索引为一个行向量，索引时按照列的方向进行顺序索引
end