clc,clear;
data = xlsread('之字的5个指标.xlsx');
data(:,1:2) = [];
data(:,end) = [];
data = mapminmax(data',0,1)';
A = [1.0000    3.0000    0.1667    0.1667    0.5000
     0.3333    1.0000    0.1250    0.1429    0.2500
     6.0000    8.0000    1.0000    4.0000    5.0000
     6.0000    7.0000    0.2500    1.0000    4.0000
     2.0000    4.0000    0.2000    0.2500    1.0000];
 w1 = AHP(A);
 w2 = shang(data);
 w = sqrt(w1.*w2)/sum(sqrt(w1.*w2));
 disp("——————————————————————————————")
disp("层次分析法权重：");   disp(w1);
disp("熵权法权重：");       disp(w2);
disp("组合赋权法权重：");   disp(w);
score = zeros(size(data,1),1);
for i=1:size(data,1)
    score(i) = sum(w.*data(i,:));
end
score