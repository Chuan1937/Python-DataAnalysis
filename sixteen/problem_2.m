% 高程数据
z = [1480 1500 1550 1510 1430 1300 1200 980
     1500 1550 1600 1550 1600 1600 1600 1550
     1500 1200 1100 1550 1600 1550 1380 1070
     1500 1200 1100 1350 1450 1200 1150 1010
     1390 1500 1500 1400 900 1100 1060 950
     1320 1450 1420 1400 1300 700 900 850
     1130 1250 1280 1230 1040 900 500 700];
 
% 水平位置和垂直位置
x = [1200 1600 2000 2400 2800 3200 3600 4000];
y = [3600 3200 2800 2400 2000 1600 1200];

% 创建插值网格
xi = linspace(min(x), max(x), 100);
yi = linspace(min(y), max(y), 100);
[XI, YI] = meshgrid(xi, yi);

% 进行插值
ZI = griddata(x, y, z, XI, YI, 'cubic');
% 绘制地貌图
figure;
surf(XI, YI, ZI);
xlabel('x');
ylabel('y');
zlabel('Elevation');
title('Smoothed Mountainous Topography');
% 绘制等高线图
figure;
contour(XI, YI, ZI);
colorbar;
xlabel('x');
ylabel('y');
title('Smoothed Contour Map');

% 绘制带有颜色映射和色标的等高线图
figure;
contourf(XI, YI, ZI);
xlabel('x');
ylabel('y');
title('Smoothed Contour Map with Color Map');
colorbar;  % 添加色标