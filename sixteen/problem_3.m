% 定义水平位置范围和间隔
x = -40:1:40;
y = -40:1:40;

% 创建网格
[X, Y] = meshgrid(x, y);

% 计算高度值
Z = 320 - X.^2/500 - Y.^2/500;

% 计算坡度
[dx, dy] = gradient(Z);
slope = atan(sqrt(dx.^2 + dy.^2));

% 设计路线
start_x = 0;  % 起点 x 坐标
start_y = 0;  % 起点 y 坐标
step_size = 0.1;  % 步长
max_slope = tan(deg2rad(30));  % 最大坡度（30°）

% 沿着坡度不超过30°的路线找到山顶
route_x = [start_x];
route_y = [start_y];
current_x = start_x;
current_y = start_y;
while true
    % 计算当前位置的坡度
    current_dx = interp2(X, Y, dx, current_x, current_y, 'spline');
    current_dy = interp2(X, Y, dy, current_x, current_y, 'spline');
    current_slope = atan(sqrt(current_dx^2 + current_dy^2));
    
    % 判断是否到达山顶
    if current_slope <= max_slope
        break;
    end
    
    % 更新下一个位置
    next_x = current_x - step_size * current_dx;
    next_y = current_y - step_size * current_dy;
    
    % 添加到路线中
    route_x = [route_x, next_x];
    route_y = [route_y, next_y];
    
    % 更新当前位置
    current_x = next_x;
    current_y = next_y;
end

% 绘制等值线图
figure;
contour(X, Y, Z);
hold on;
plot(route_x, route_y, 'r', 'LineWidth', 2);
xlabel('x');
ylabel('y');
title('Contour Map with Route');

% 绘制三维图
figure;
surf(X, Y, Z);
hold on;
plot3(route_x, route_y, interp2(X, Y, Z, route_x, route_y, 'spline'), 'r', 'LineWidth', 2);
xlabel('x');
ylabel('y');
zlabel('Elevation');
title('Mountain Topography with Route');
