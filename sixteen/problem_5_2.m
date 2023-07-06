% 定义多项式 p(x)
p = @(x) -38.89*x.^2 + 126.11*x - 3.42;

% 求解多项式导数为零的点，即最大值点
syms x
dp = diff(p(x));
max_point = solve(dp == 0, x);
max_point = double(max_point);

% 计算最大值对应的加热效率
max_efficiency = p(max_point);

% 绘制图示
x_values = linspace(0, 2, 100);
y_values = p(x_values);

figure;
plot(x_values, y_values,LineWidth=2);
hold on;
plot(max_point, max_efficiency, 'ro', 'MarkerSize', 8);
text(max_point, max_efficiency, sprintf('最大效率点: (%.2f, %.2f)', max_point, max_efficiency), ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
hold off;
grid on;
xlabel('空气流量');
ylabel('加热效率');
title('加热效率与空气流量关系');
legend('加热效率曲线', '最大效率点');
fprintf('最大效率点: (%.2f, %.2f)', max_point, max_efficiency)