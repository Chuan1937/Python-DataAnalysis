    % 定义方程的函数
    f = @(x) 2*x^3 - 4*x^2 + 3*x - 6;
    % 定义搜索范围
    a = -10;b = 10;
    % 定义误差容限
    epsilon = 1e-6;
    % 进行迭代求解
    while (b - a) > epsilon
        c = (a + b) / 2;  % 取中点
        fa = f(a);
        fc = f(c);
        if abs(fc) < epsilon
            break;  % 已经找到根
        end
        if sign(fa) ~= sign(fc)
            b = c;  % 根位于左半边
        else
            a = c;  % 根位于右半边
        end
    end
    root = c % 返回根的近似值

