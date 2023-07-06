% 设置实验参数
numPoints = 1e4;  % 抽样点数

% 生成随机点
points = rand(numPoints, 2) * 2 - 1;  % 生成在正方形内随机分布的点

% 计算点在单位圆内的数量
insideCircle = sum((points(:, 1).^2 + points(:, 2).^2) <= 1);

% 计算单位圆和正方形的面积比例
circleArea = insideCircle / numPoints;  % 单位圆面积
squareArea = 4;  % 正方形面积

% 绘制图形
figure;
hold on;

% 绘制正方形轮廓
x_square = [-1 -1 1 1 -1];
y_square = [-1 1 1 -1 -1];
plot(x_square, y_square, 'b', 'LineWidth', 2);

% 绘制单位圆轮廓
theta = linspace(0, 2*pi, 100);
x_circle = cos(theta);
y_circle = sin(theta);
plot(x_circle, y_circle, 'r', 'LineWidth', 2);

% 绘制抽样点
plot(points(:, 1), points(:, 2), 'k.', 'MarkerSize', 4);

hold off;
axis equal;
title('蒙特卡洛实验 - 单位圆和正方形轮廓');
legend('正方形', '单位圆', '抽样点');


% 输出结果
fprintf('通过蒙特卡洛实验估计的单位圆和正方形的面积比例: %.4f\n', circleArea);
fprintf('单位圆和正方形的理论面积比例: %.4f\n', pi/4);
fprintf('实验误差: %.4f\n', abs(circleArea - pi/4));