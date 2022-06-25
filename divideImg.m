clc,clear
originImg = imresize(imread('test.jpg'),0.2);
img = im2double(originImg);
% 中值滤波
img2 = zeros(size(img));
for i=1:3
    img2(:,:,i) = medfilt2(img(:,:,i));
end
% subplot(1,2,1);
% title('before');
% imshow(img);
% subplot(1,2,2);
% title('after');
% imshow(img2);
% 二值化
img = img2;
img2 = 1-im2bw(img,0.35);
% figure(2);
% subplot(1,2,1);
% title('before');
% imshow(img);
% subplot(1,2,2);
% title('after');
% imshow(img2);
% 形态学：腐蚀4次，膨胀4次，实测效果不好
% img = img2;
% se = ones(5,5);
% img2 = imerode(imerode(imerode(imerode(img,se),se),se),se);
% img2 = imdilate(imdilate(imdilate(imdilate(img2,se),se),se),se);
% figure(3);
% subplot(1,2,1);
% title('before');
% imshow(img);
% subplot(1,2,2);
% title('after');
% imshow(img2);

% 单字切割
img = img2;
x = sum(img,1);
y = sum(img,2);
tx = 1:size(img,2);
ty = x;
f = fit(tx', ty', 'smoothingspline' , 'SmoothingParam' ,0.00067321295);
plot(tx,ty,'LineWidth',1); 
hold on
plot(f,'r');
legend('原y方向直方数据','拟合结果');
f = f(1:size(img,2))';                  % 转换为double类型
xline = find(diff(sign(diff(f)))<0)+1;  % 查找波峰
xline(end) = [];                        % 去掉最后一个

% 分列
img2 = img;
img2(:,[xline]) = 0;
figure(4);
imshow(img2);
% 逐列分行
YLine = [];     % 储存每次运行的yline（行分割）结果
num = 1;        % 标记序号

for i=length(xline)+1:1
    img= img2;
    if i ~= 1 && i ~= length(xline)+1
        colimg = img(:,xline(i-1):xline(i));
    elseif i == 1
        colimg = img(:,1:xline(i)); 
    else
        colimg = img(:,xline(i-1):size(img,2));
    end
    tx = 1:size(img,1);
    ty = sum(colimg,2)';
%     figure(5);
%     plot(ty)
    f = fit(tx', ty', 'smoothingspline' , 'SmoothingParam' ,9.1162531e-05);
    f = f(1:size(img,1))';                  % 转换为double类型
    % f(end) = [];                          % 去掉最后一个
    yline = find(diff(sign(diff(f)))<0)+1;  % 查找波峰
    img2 = img;
    if i ~= 1 && i ~= length(xline)+1
        img2([yline],xline(i-1):xline(i)) = 0;
    elseif i == 1
        img2([yline],1:xline(i)) = 0; 
    else
        img2([yline],xline(i-1):size(img,2)) = 0;
    end
    hold on
    imshow(img2);
    res = [];
    for j=1:length(yline)+1
        if i ~= 1 && i ~= length(xline)+1
            if j ~= 1 && j ~= length(yline)+1
                res = originImg(yline(j-1):yline(j),1:xline(i));
            elseif j == 1
                res = originImg(1:yline(j),1:xline(i)); 
            else
                res = originImg(yline(j-1):size(img,2),1:xline(i));
            end
        elseif i == 1
            if j ~= 1 && j ~= length(yline)+1
                res = originImg(yline(j-1):yline(j),1:xline(i));
            elseif j == 1
                res = originImg(1:yline(j),1:xline(i)); 
            else
                res = originImg(yline(j-1):size(img,2),1:xline(i));
            end
        else
            if j ~= 1 && j ~= length(yline)+1
                res = originImg(yline(j-1):yline(j),xline(i-1):size(img,2));
            elseif j == 1
                res = originImg(1:yline(j),xline(i-1):size(img,2)); 
            else
                res = originImg(yline(j-1):size(img,2),xline(i-1):size(img,2));
            end
        end
    end
    imgName = ['./3肅宗保母王氏墓誌并蓋/' num2str(num,'%03d') '.tif'];
    num = num+1;
    imwrite(res,imgName);
end
% imwrite(img2, '形态学2.png');