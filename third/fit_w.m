%% 
clear;clc;close;
data=readmatrix("武汉市累计确诊病例.xlsx");
plot(data(:,1),data(:,2));
bar(data(:,2));
data(48,:)=[];%删除异常值
time=data(:,1);
datanum=datenum(time);
pop=data(:,2);
plot(datanum,pop);
datetick('x','mm/dd')
hold on

%%
[xData, yData] = prepareCurveData( time, pop );

% 设置 fittype 和选项。
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.Normalize = 'on';
opts.SmoothingParam = 0.845171901039745;

% 对数据进行模型拟合。
[fitresult, gof] = fit( xData, yData, ft, opts );

% 绘制数据拟合图。
h = plot(fitresult, xData, yData );
legend( h, 'pop vs. time', '无标题拟合 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% 为坐标区加标签
xlabel( 'time', 'Interpreter', 'none' );
ylabel( 'pop', 'Interpreter', 'none' );
grid on
%%
data=readmatrix("武汉市累计确诊病例(3)(2)");
time=data(:,1);
datanum=datenum(time);
scatter(time,data(:,2))
datetick('x','mm/dd')
xlabel('日期')
ylabel('累计确诊病例/个')
grid on
