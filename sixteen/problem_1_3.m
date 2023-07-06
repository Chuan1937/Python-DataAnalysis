% 定义矩阵 A 和 B
A = [1 2 3; 4 5 6; 7 8 9];
B = [9 8 7; 6 5 4; 3 2 1];

% (1) 实现 A+B，A-B，A*B，B^(-1)，A^(-1)
C1 = A + B;  % A+B
C2 = A - B;  % A-B
C3 = A * B;  % A*B
C4 = pinv(B); % B^(-1)
C5 = pinv(A); % A^(-1)

% (2) 求 A，B 中每列的最大与最小元素（使用循环结构）
[m, n] = size(A);
col_min_A = zeros(1, n);
col_max_A = zeros(1, n);
for i = 1:n
    col_min_A(i) = A(1, i);
    col_max_A(i) = A(1, i);
    for j = 2:m
        if A(j, i) < col_min_A(i)
            col_min_A(i) = A(j, i);
        end
        if A(j, i) > col_max_A(i)
            col_max_A(i) = A(j, i);
        end
    end
end

[m, n] = size(B);
col_min_B = zeros(1, n);
col_max_B = zeros(1, n);
for i = 1:n
    col_min_B(i) = B(1, i);
    col_max_B(i) = B(1, i);
    for j = 2:m
        if B(j, i) < col_min_B(i)
            col_min_B(i) = B(j, i);
        end
        if B(j, i) > col_max_B(i)
            col_max_B(i) = B(j, i);
        end
    end
end

% (3) 求 A，B 中的最大与最小元素（使用循环结构）
min_A = A(1, 1);
max_A = A(1, 1);
for i = 1:m
    for j = 1:n
        if A(i, j) < min_A
            min_A = A(i, j);
        end
        if A(i, j) > max_A
            max_A = A(i, j);
        end
    end
end

min_B = B(1, 1);
max_B = B(1, 1);
for i = 1:m
    for j = 1:n
        if B(i, j) < min_B
            min_B = B(i, j);
        end
        if B(i, j) > max_B
            max_B = B(i, j);
        end
    end
end

% 显示结果
disp('A + B:');
disp(C1);
disp('A - B:');
disp(C2);
disp('A * B:');
disp(C3);
disp('B^(-1):');
disp(C4);
disp('A^(-1):');
disp(C5);

disp('A 中每列的最小元素:');
disp(col_min_A);
disp('A 中每列的最大元素:');
disp(col_max_A);
disp('B 中每列的最小元素:');
disp(col_min_B);
disp('B 中每列的最大元素:');
disp(col_max_B);

disp('A 的最小元素:');
disp(min_A);
disp('A 的最大元素:');
disp(max_A);
disp('B 的最小元素:');
disp(min_B);
disp('B 的最大元素:');
disp(max_B);
