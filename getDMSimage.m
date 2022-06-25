function res = getDMSimage(flag, persent)
clc;
switch flag
    case 1  % 之
        imglist = 1:21;
        imgnum = [12 10 6 14 1 12 16 12 1 10 10 10 7 6 10 8 10 10 10 10 6];
    case 2  % 道
        imglist = [1 2 4 6 10 11 13 16 17 18 19 20 21];
        imgnum = [3 3 0 2 0 1 0 0 0 2 4 0 3 0 0 3 2 1 4 7 2];
    case 3  % 以
        imglist = [1:11 13:21];
        imgnum = [7 6 2 6 3 6 5 5 1 1 7 0 5 3 2 3 8 10 6 5 1];
end
n = sum(imgnum);
data = zeros(50,50,n);
k = 1;
for i=imglist
    a = imgnum;
    a(imgnum==0) = [];
    for j=1:a(find(imglist==i))
        switch flag
            case 1  % 之
                name = [ './之/' num2str(i) '.' num2str(j) '.png'];
            case 2  % 道
                name = [ './道/' num2str(i) '.' num2str(j) '.png'];
            case 3  % 以
                name = [ './以/' num2str(i) '.' num2str(j) '.png'];
        end  
        data(:,:,k) = im2bw(imread(name));
        k = k+1;
    end
end
% 删除一些
deleteIndex = randperm(n,round((1-persent)*n));
data(:,:,deleteIndex) = [];
n = size(data,3);

map = zeros(n,n);  % 之 SSIM相似度矩阵
for i=1:n
    for j=1:n
        if j >= i
            map(i,j) = 0;
        else
            map(i,j) = 1-ssim(data(:,:,i),data(:,:,j));
        end
    end
end

t = zeros(n,n);   % 之 不相似度对称矩阵
name = string;
for i=1:n
    for j=1:n
        if j > i
            % 把下三角矩阵以主对角线为轴复制，变成对称矩阵
            map(i,j)=map(j,i);
        end
        
    end
end

for i=1:n
    for j=1:n
        t(i,j)=-0.5*(map(i,j)^2 -1/n*map(i,:)*map(i,:)' -1/n*map(:,j)'*map(:,j) +1/n^2*sum(sum(map.^2)));
    end
end
[V,D] = eig(t);
X = V(:,1:2)*D(1:2,1:2).^(1/2);

% 赋予颜色并绘制
img = zeros(2400,3200,3);
for i=1:n
    mask = zeros(50,50,3);
    if i <= sum(imgnum(1:1))
        mask(:,:,1) = 174;
        mask(:,:,2) = 0;
        mask(:,:,3) = 0;
    elseif i <= sum(imgnum(1:2))
        mask(:,:,1) = 224;
        mask(:,:,2) = 0;
        mask(:,:,3) = 4;
    elseif i <= sum(imgnum(1:3))
        mask(:,:,1) = 255;
        mask(:,:,2) = 77;
        mask(:,:,3) = 0;
    elseif i <= sum(imgnum(1:4))
        mask(:,:,1) = 255;
        mask(:,:,2) = 175;
        mask(:,:,3) = 42;
    elseif i <= sum(imgnum(1:5))
        mask(:,:,1) = 222;
        mask(:,:,2) = 145;
        mask(:,:,3) = 18;
    elseif i <= sum(imgnum(1:6))
        mask(:,:,1) = 243;
        mask(:,:,2) = 234;
        mask(:,:,3) = 87;
    elseif i <= sum(imgnum(1:7))
        mask(:,:,1) = 154;
        mask(:,:,2) = 238;
        mask(:,:,3) = 28;
    elseif i <= sum(imgnum(1:8))
        mask(:,:,1) = 17;
        mask(:,:,2) = 203;
        mask(:,:,3) = 10;
    elseif i <= sum(imgnum(1:9))
        mask(:,:,1) = 0;
        mask(:,:,2) = 127;
        mask(:,:,3) = 0;
    elseif i <= sum(imgnum(1:10))
        mask(:,:,1) = 34;
        mask(:,:,2) = 255;
        mask(:,:,3) = 165;
    elseif i <= sum(imgnum(1:11))
        mask(:,:,1) = 65;
        mask(:,:,2) = 239;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum(1:12))
        mask(:,:,1) = 51;
        mask(:,:,2) = 213;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum(1:13))
        mask(:,:,1) = 38;
        mask(:,:,2) = 135;
        mask(:,:,3) = 253;
    elseif i <= sum(imgnum(1:14))
        mask(:,:,1) = 0;
        mask(:,:,2) = 12;
        mask(:,:,3) = 238;
    elseif i <= sum(imgnum(1:15))
        mask(:,:,1) = 0;
        mask(:,:,2) = 85;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum(1:16))
        mask(:,:,1) = 0;
        mask(:,:,2) = 28;
        mask(:,:,3) = 172;
    elseif i <= sum(imgnum(1:17))
        mask(:,:,1) = 127;
        mask(:,:,2) = 49;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum(1:18))
        mask(:,:,1) = 194;
        mask(:,:,2) = 161;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum(1:19))
        mask(:,:,1) = 103;
        mask(:,:,2) = 0;
        mask(:,:,3) = 222;
    elseif i <= sum(imgnum(1:20))
        mask(:,:,1) = 250;
        mask(:,:,2) = 165;
        mask(:,:,3) = 255;
    else % 21
        mask(:,:,1) = 255;
        mask(:,:,2) = 34;
        mask(:,:,3) = 221;
    end
    for j=1:3
        x = round((-X(i,2)+0.5)*3200);
        y = round((X(i,1)+0.5)*2400);
        img(y-25+1:y+25,x-25+1:x+25,j)= data(:,:,i)/255 .* mask(:,:,j);
    end 
end
res = img;
end