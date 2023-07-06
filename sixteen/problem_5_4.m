speed = [20 30 40 50 60 70 80 90 100 110 120 130 140 150]; % 行车速度
braking_distance = [3.15 7.08 12.59 19.68 28.34 38.57 50.4 63.75 78.71 95.22 113.29 132.93 154.12 176.87]; % 制动距离

reaction_time = 10; % 反应时间
safe_distance = 10; % 安全距离
visual_distance = 120; % 有效视距

% 计算反应距离
reaction_distance = reaction_time * (speed / 3.6); % 将速度转换为m/s

% 计算总距离
total_distance = reaction_distance + braking_distance + safe_distance;

% 寻找满足条件的最大时速
max_speed = max(speed(total_distance <= visual_distance));
fprintf('驾驶员在该路面行车时，时速最高不能超过 %d km/h。\n', max_speed);

% 绘制制动距离和总距离随行车速度变化的图表
figure
plot(speed, braking_distance, 'bo-', speed, total_distance, 'ro-');
xlabel('行车速度 (km/h)');
ylabel('距离 (m)');
legend('制动距离', '总距离');
title('行车速度与制动距离、总距离的关系');

%%
target_speed = 125; % 目标时速

% 线性插值计算可视距离
visual_distance_linear = interp1(speed, total_distance, target_speed, 'linear');

fprintf('设计高速公路时，驾驶者在公路上任一点的可视距离为 %.2f m（线性插值）。\n', visual_distance_linear);

%%
% 多项式拟合
coefficients = polyfit(speed, total_distance, 5); % 使用五次多项式进行拟合
polynomial = polyval(coefficients, speed);

% 绘制拟合曲线
figure
plot(speed, total_distance, 'bo-', speed, polynomial, 'r-');
xlabel('行车速度 (km/h)');
ylabel('距离 (m)');
legend('总距离', '多项式拟合');
title('行车速度与总距离的关系');

% 计算拟合曲线上的可视距离
visual_distance_polyfit = polyval(coefficients, target_speed);

fprintf('设计高速公路时，驾驶者在公路上任一点的可视距离为 %.2f m（多项式拟合）。\n', visual_distance_polyfit);
