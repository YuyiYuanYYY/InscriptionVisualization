clc,clear
% 之
imglist = 0:21;
% 以
% imglist = [0:11 13:21];
imgnum = ones(1,22);
res = zeros(21,2);
figure;
 k = 1;
for i=imglist
    img = imread(['./之/' num2str(i) '.1.png']);
    % img = imread(['./以/' num2str(i) '.1.png']);
    img = img(:,:,1);
    % 着墨量
    res(k,1) = length(find(img==255))./2500;
    % 重心
    x = sum(img,1);
    y = sum(img,2);
    % x方向重心坐标
    tx = 1:size(img,2);
    ty = x;
    f = fit(tx', ty', 'smoothingspline' , 'SmoothingParam' ,0.035476099);
    f = f(1:size(img,2))';                  % 转换为double类型
    xpoint = find(diff(sign(diff(f)))<0)+1;  % 查找波峰
    if length(xpoint) ~= 1
        xpoint = mean(xpoint);
    end
    % y方向重心坐标
    tx = 1:size(img,1);
    ty = y;
    f = fit(tx', ty, 'smoothingspline' , 'SmoothingParam' ,0.035476099);
    f = f(1:size(img,1))';                   % 转换为double类型
    ypoint = find(diff(sign(diff(f)))<0)+1;  % 查找波峰
    if length(ypoint) ~= 1
        ypoint = mean(ypoint);
    end
    res(k,2) = sqrt((xpoint-24)^2 + (ypoint-28)^2);
%     res(k,1) = xpoint;
%     res(k,2) = ypoint;
    subplot(3,7,k);
    imshow(img);
    hold on
    scatter(xpoint,ypoint,'r','filled');
    k = k+1;
end
xlswrite('以字的5个指标.xlsx',res);