% 获取积分上下限
a = input('请输入积分下限 a：');
b = input('请输入积分上限 b：');
% 定义待积分函数
f = @(x) x^2 - 2*x + 2;
% 设置梯形数量
n = 1000;
% 使用梯形法求积分
integral_value = trapezoidal_rule(f, a, b, n);
% 显示积分结果
fprintf('定积分的值为: %f\n', integral_value)
function integral_value = trapezoidal_rule(f, a, b, n)% f: 待积分函数% a, b: 积分上下限% n: 梯形数量% 计算步长
    h = (b - a) / n;
    % 计算梯形法求积分的和
    sum = 0;
    for i = 1:n-1
        x = a + i * h;
        sum = sum + f(x);
    end
    % 计算积分值
    integral_value = h * (0.5 * (f(a) + f(b)) + sum);
end
