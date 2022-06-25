function [w]=shang(x)
% 函数shang.m, 实现用熵值法求各指标(列）的权重及各数据行的得分
% s返回各行得分, w返回各列权重
[n,m] = size(x);

[X,ps] = mapminmax(x');
ps.ymin = 0.002;                % 归一化后的最小值
ps.ymax = 0.996;                % 归一化后的最大值
ps.yrange = ps.ymax-ps.ymin;    % 归一化后的极差
X = mapminmax(x',ps);
% mapminmax('reverse',xx,ps);
X = X';

for i=1:n
    for j=1:m
        p(i,j) = X(i,j)/sum(X(:,j));
    end
end

k = 1/log(n);
for j=1:m
    e(j) = -k*sum(p(:,j).*log(p(:,j)));
end
d = ones(1,m)-e;  % 计算信息熵冗余度
w = d./sum(d);    % 求权值w