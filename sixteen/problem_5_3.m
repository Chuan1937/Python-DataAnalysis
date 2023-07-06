% 给定数据
x = [0 3 5 7 9 11 12 13 14 15];
y = [0 1.2 1.7 2.0 2.1 2.0 1.8 1.2 1.0 1.6];

% 定义要插值的 x 值
x_interp = 0:0.1:15;

% 线性插值
y_linear = interp1(x, y, x_interp, 'linear');

% 多项式插值
p = polyfit(x, y, length(x) - 1);
y_poly = polyval(p, x_interp);

% 样条插值
y_spline = spline(x, y, x_interp);

% 绘制图示
figure;
plot(x, y, 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);
hold on;
plot(x_interp, y_linear, 'c-', 'LineWidth', 1.5);
plot(x_interp, y_poly, 'g--', 'LineWidth', 1.5);
plot(x_interp, y_spline, 'k-', 'LineWidth', 1.5);
hold off;
grid on;
xlabel('x');
ylabel('y');
title('插值方法比较');
legend('给定数据', '线性插值', '多项式插值', '样条插值');
