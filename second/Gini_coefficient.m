% 其中G为基尼系数，
% 将14地州的人均卫生资源量按从小到大排序，
% i是按人均卫生资源量排序后的样本量，
% Xi代表新疆各地州人口或地理面积的累计百分比，
% Yi代表新疆各地州卫生资源量的累计百分比
%$G=\sum_{i}^{n-1}(X_{i}Y_{i+1}-X_{i+1}Y_{i})$
%% 按人口计算基尼系数
clear;clc;close;
data=readmatrix("medical_data.xlsx",Sheet="data_2020");
ind=[4 5 6];
k=1;
for j=[9 11 13]
    gini=0;
    data_sort=sortrows(data,j);
    x=data_sort(:,2)/sum(data_sort(:,2));
    x_l=cumsum(x);
    y=data_sort(:,ind(k))/sum(data_sort(:,ind(k)));
    y_l=cumsum(y);
    k=k+1;
    for i=1:13
        temp=x_l(i)*y_l(i+1)-x_l(i+1)*y_l(i);
        gini=gini+temp;        
    end
    gini
end
%% 按面积计算基尼系数
clear;clc;close;
data=readmatrix("medical_data.xlsx",Sheet="data_2020");
ind=[4 5 6];
k=1;
for j=[10 12 14]
    gini=0;
    data_sort=sortrows(data,j);
    x=data_sort(:,3)/sum(data_sort(:,3));
    x_l=cumsum(x);
    y=data_sort(:,ind(k))/sum(data_sort(:,ind(k)));
    y_l=cumsum(y);
    k=k+1;
    for i=1:13
        temp=x_l(i)*y_l(i+1)-x_l(i+1)*y_l(i);
        gini=gini+temp;        
    end
    gini
end
