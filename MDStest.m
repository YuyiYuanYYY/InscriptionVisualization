clc,clear
% 之
imglist1 = 1:21;
imgnum1 = [12 10 6 14 1 12 16 12 1 10 10 10 7 6 10 8 10 10 10 10 6];
% 道
imglist2 = [1 2 4 6 10 11 13 16 17 18 19 20 21];
imgnum2 = [3 3 0 2 0 1 0 0 0 2 4 0 3 0 0 3 2 1 4 7 2];
% 以
imglist3 = [1:11 13:21];
imgnum3 = [7 6 2 6 3 6 5 5 1 1 7 0 5 3 2 3 8 10 6 5 1];
n1 = sum(imgnum1);
n2 = sum(imgnum2);
n3 = sum(imgnum3);
data1 = zeros(50,50,n1);
data2 = zeros(50,50,n2);
data3 = zeros(50,50,n3);
%% 之
k = 1;
for i=imglist1
    a = imgnum1;
    a(imgnum1==0) = [];
    for j=1:a(find(imglist1==i))
        name = [ './之/' num2str(i) '.' num2str(j) '.png'];
        data1(:,:,k) = im2bw(imread(name));
        k = k+1;
    end
end
map1 = zeros(n1,n1);  % 之 SSIM相似度矩阵
for i=1:n1
    for j=1:n1
        if j >= i
            map1(i,j) = 0;
        else
            map1(i,j) = 1-ssim(data1(:,:,i),data1(:,:,j));
        end
    end
end

t1 = zeros(n1,n1);   % 之 不相似度对称矩阵
name1 = string;
for i=1:n1
    for j=1:n1
        if j > i
            % 把下三角矩阵以主对角线为轴复制，变成对称矩阵
            map1(i,j)=map1(j,i);
        end
        
    end
end
% 给标记点做名字下标
for i=imglist1
    a = imgnum1;
    a(imgnum1==0) = [];
    for j=1:a(find(imglist1==i))
        name1 = [name1 [num2str(i) '.' num2str(j)]];
    end
end
name1(1) = [];
for i=1:n1
    for j=1:n1
        t1(i,j)=-0.5*(map1(i,j)^2 -1/n1*map1(i,:)*map1(i,:)' -1/n1*map1(:,j)'*map1(:,j) +1/n1^2*sum(sum(map1.^2)));
    end
end
[V,D] = eig(t1);
X = V(:,1:2)*D(1:2,1:2).^(1/2);
figure;
for i=1:n1
    if i <= sum(imgnum1(1:1))
        scatter(-X(i,2),X(i,1),[],[174 0 0]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:2))
        scatter(-X(i,2),X(i,1),[],[224 0 4]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:3))
        scatter(-X(i,2),X(i,1),[],[255 77 0]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:4))
        scatter(-X(i,2),X(i,1),[],[255 175 42]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:5))
        scatter(-X(i,2),X(i,1),[],[222 145 18]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:6))
        scatter(-X(i,2),X(i,1),[],[243 234 87]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:7))
        scatter(-X(i,2),X(i,1),[],[154 238 28]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:8))
        scatter(-X(i,2),X(i,1),[],[17 203 10]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:9))
        scatter(-X(i,2),X(i,1),[],[0 127 0]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:10))
        scatter(-X(i,2),X(i,1),[],[34 255 165]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:11))
        scatter(-X(i,2),X(i,1),[],[65 239 255]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:12))
        scatter(-X(i,2),X(i,1),[],[51 213 255]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:13))
        scatter(-X(i,2),X(i,1),[],[38 135 253]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:14))
        scatter(-X(i,2),X(i,1),[],[0 12 238]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:15))
        scatter(-X(i,2),X(i,1),[],[0 85 255]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:16))
        scatter(-X(i,2),X(i,1),[],[0 28 172]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:17))
        scatter(-X(i,2),X(i,1),[],[127 49 255]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:18))
        scatter(-X(i,2),X(i,1),[],[194 161 255]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:19))
        scatter(-X(i,2),X(i,1),[],[103 0 222]/255,'filled');
        hold on
    elseif i <= sum(imgnum1(1:20))
        scatter(-X(i,2),X(i,1),[],[250 165 255]/255,'filled');
        hold on
    else % 21
        scatter(-X(i,2),X(i,1),[],[255 34 221]/255,'filled');
        hold on
    end
end
for i=1:n1
    text(-X(i,2)+0.005,X(i,1)-0.005,name1(i),'FontSize',6,'Interpreter','none');
end
axis([-0.45,0.45,-0.45,0.45]);
title('MDS聚类结果');

% 赋予颜色并绘制
img = zeros(2400,3200,3);
for i=1:n1
    mask = zeros(50,50,3);
    if i <= sum(imgnum1(1:1))
        mask(:,:,1) = 174;
        mask(:,:,2) = 0;
        mask(:,:,3) = 0;
    elseif i <= sum(imgnum1(1:2))
        mask(:,:,1) = 224;
        mask(:,:,2) = 0;
        mask(:,:,3) = 4;
    elseif i <= sum(imgnum1(1:3))
        mask(:,:,1) = 255;
        mask(:,:,2) = 77;
        mask(:,:,3) = 0;
    elseif i <= sum(imgnum1(1:4))
        mask(:,:,1) = 255;
        mask(:,:,2) = 175;
        mask(:,:,3) = 42;
    elseif i <= sum(imgnum1(1:5))
        mask(:,:,1) = 222;
        mask(:,:,2) = 145;
        mask(:,:,3) = 18;
    elseif i <= sum(imgnum1(1:6))
        mask(:,:,1) = 243;
        mask(:,:,2) = 234;
        mask(:,:,3) = 87;
    elseif i <= sum(imgnum1(1:7))
        mask(:,:,1) = 154;
        mask(:,:,2) = 238;
        mask(:,:,3) = 28;
    elseif i <= sum(imgnum1(1:8))
        mask(:,:,1) = 17;
        mask(:,:,2) = 203;
        mask(:,:,3) = 10;
    elseif i <= sum(imgnum1(1:9))
        mask(:,:,1) = 0;
        mask(:,:,2) = 127;
        mask(:,:,3) = 0;
    elseif i <= sum(imgnum1(1:10))
        mask(:,:,1) = 34;
        mask(:,:,2) = 255;
        mask(:,:,3) = 165;
    elseif i <= sum(imgnum1(1:11))
        mask(:,:,1) = 65;
        mask(:,:,2) = 239;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum1(1:12))
        mask(:,:,1) = 51;
        mask(:,:,2) = 213;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum1(1:13))
        mask(:,:,1) = 38;
        mask(:,:,2) = 135;
        mask(:,:,3) = 253;
    elseif i <= sum(imgnum1(1:14))
        mask(:,:,1) = 0;
        mask(:,:,2) = 12;
        mask(:,:,3) = 238;
    elseif i <= sum(imgnum1(1:15))
        mask(:,:,1) = 0;
        mask(:,:,2) = 85;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum1(1:16))
        mask(:,:,1) = 0;
        mask(:,:,2) = 28;
        mask(:,:,3) = 172;
    elseif i <= sum(imgnum1(1:17))
        mask(:,:,1) = 127;
        mask(:,:,2) = 49;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum1(1:18))
        mask(:,:,1) = 194;
        mask(:,:,2) = 161;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum1(1:19))
        mask(:,:,1) = 103;
        mask(:,:,2) = 0;
        mask(:,:,3) = 222;
    elseif i <= sum(imgnum1(1:20))
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
        img(y-25+1:y+25,x-25+1:x+25,j)= data1(:,:,i)/255 .* mask(:,:,j);
    end 
end
figure;
imshow(img);
% imwrite(img,'之DMS.png');
LocationVar(-X(:,2),X(:,1),imgnum1,1);
%% 道
k = 1;
for i=imglist2
    a = imgnum2;
    a(imgnum2==0) = [];
    for j=1:a(find(imglist2==i))
        name = [ './道/' num2str(i) '.' num2str(j) '.png'];
        data2(:,:,k) = im2bw(imread(name));
        k = k+1;
    end
end
map2 = zeros(n2,n2);  % 道 SSIM相似度矩阵
for i=1:n2
    for j=1:n2
        if j >= i
            map2(i,j) = 0;
        else
            map2(i,j) = 1-ssim(data2(:,:,i),data2(:,:,j));
        end
    end
end

t2 = zeros(n2,n2);   % 之 不相似度对称矩阵
name2 = string;
for i=1:n2
    for j=1:n2
        if j > i
            % 把下三角矩阵以主对角线为轴复制，变成对称矩阵
            map2(i,j)=map2(j,i);
        end
    end
end
% 给标记点做名字下标
for i=imglist2
    a = imgnum2;
    a(imgnum2==0) = [];
    for j=1:a(find(imglist2==i))
        name2 = [name2 [num2str(i) '.' num2str(j)]];
    end
end
name2(1) = [];
for i=1:n2
    for j=1:n2
        t2(i,j)=-0.5*(map2(i,j)^2 -1/n2*map2(i,:)*map2(i,:)' -1/n2*map2(:,j)'*map2(:,j) +1/n2^2*sum(sum(map2.^2)));
    end
end
[V,D] = eig(t2);
X = V(:,1:2)*D(1:2,1:2).^(1/2);
figure;
for i=1:n2
    if i <= sum(imgnum2(1:1))
        scatter(-X(i,2),X(i,1),[],[174 0 0]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:2))
        scatter(-X(i,2),X(i,1),[],[224 0 4]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:3))
        scatter(-X(i,2),X(i,1),[],[255 77 0]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:4))
        scatter(-X(i,2),X(i,1),[],[255 175 42]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:5))
        scatter(-X(i,2),X(i,1),[],[222 145 18]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:6))
        scatter(-X(i,2),X(i,1),[],[243 234 87]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:7))
        scatter(-X(i,2),X(i,1),[],[154 238 28]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:8))
        scatter(-X(i,2),X(i,1),[],[17 203 10]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:9))
        scatter(-X(i,2),X(i,1),[],[0 127 0]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:10))
        scatter(-X(i,2),X(i,1),[],[34 255 165]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:11))
        scatter(-X(i,2),X(i,1),[],[65 239 255]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:12))
        scatter(-X(i,2),X(i,1),[],[51 213 255]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:13))
        scatter(-X(i,2),X(i,1),[],[38 135 253]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:14))
        scatter(-X(i,2),X(i,1),[],[0 12 238]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:15))
        scatter(-X(i,2),X(i,1),[],[0 85 255]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:16))
        scatter(-X(i,2),X(i,1),[],[0 28 172]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:17))
        scatter(-X(i,2),X(i,1),[],[127 49 255]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:18))
        scatter(-X(i,2),X(i,1),[],[194 161 255]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:19))
        scatter(-X(i,2),X(i,1),[],[103 0 222]/255,'filled');
        hold on
    elseif i <= sum(imgnum2(1:20))
        scatter(-X(i,2),X(i,1),[],[250 165 255]/255,'filled');
        hold on
    else % 21
        scatter(-X(i,2),X(i,1),[],[255 34 221]/255,'filled');
        hold on
    end
end
for i=1:n2
    text(-X(i,2)+0.005,X(i,1)-0.005,name2(i),'FontSize',6,'Interpreter','none');
end
axis([-0.45,0.45,-0.45,0.45]);
title('MDS聚类结果');

% 赋予颜色并绘制
img = zeros(2400,3200,3);
for i=1:n2
    mask = zeros(50,50,3);
    if i <= sum(imgnum2(1:1))
        mask(:,:,1) = 174;
        mask(:,:,2) = 0;
        mask(:,:,3) = 0;
    elseif i <= sum(imgnum2(1:2))
        mask(:,:,1) = 224;
        mask(:,:,2) = 0;
        mask(:,:,3) = 4;
    elseif i <= sum(imgnum2(1:3))
        mask(:,:,1) = 255;
        mask(:,:,2) = 77;
        mask(:,:,3) = 0;
    elseif i <= sum(imgnum2(1:4))
        mask(:,:,1) = 255;
        mask(:,:,2) = 175;
        mask(:,:,3) = 42;
    elseif i <= sum(imgnum2(1:5))
        mask(:,:,1) = 222;
        mask(:,:,2) = 145;
        mask(:,:,3) = 18;
    elseif i <= sum(imgnum2(1:6))
        mask(:,:,1) = 243;
        mask(:,:,2) = 234;
        mask(:,:,3) = 87;
    elseif i <= sum(imgnum2(1:7))
        mask(:,:,1) = 154;
        mask(:,:,2) = 238;
        mask(:,:,3) = 28;
    elseif i <= sum(imgnum2(1:8))
        mask(:,:,1) = 17;
        mask(:,:,2) = 203;
        mask(:,:,3) = 10;
    elseif i <= sum(imgnum2(1:9))
        mask(:,:,1) = 0;
        mask(:,:,2) = 127;
        mask(:,:,3) = 0;
    elseif i <= sum(imgnum2(1:10))
        mask(:,:,1) = 34;
        mask(:,:,2) = 255;
        mask(:,:,3) = 165;
    elseif i <= sum(imgnum2(1:11))
        mask(:,:,1) = 65;
        mask(:,:,2) = 239;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum2(1:12))
        mask(:,:,1) = 51;
        mask(:,:,2) = 213;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum2(1:13))
        mask(:,:,1) = 38;
        mask(:,:,2) = 135;
        mask(:,:,3) = 253;
    elseif i <= sum(imgnum2(1:14))
        mask(:,:,1) = 0;
        mask(:,:,2) = 12;
        mask(:,:,3) = 238;
    elseif i <= sum(imgnum2(1:15))
        mask(:,:,1) = 0;
        mask(:,:,2) = 85;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum2(1:16))
        mask(:,:,1) = 0;
        mask(:,:,2) = 28;
        mask(:,:,3) = 172;
    elseif i <= sum(imgnum2(1:17))
        mask(:,:,1) = 127;
        mask(:,:,2) = 49;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum2(1:18))
        mask(:,:,1) = 194;
        mask(:,:,2) = 161;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum2(1:19))
        mask(:,:,1) = 103;
        mask(:,:,2) = 0;
        mask(:,:,3) = 222;
    elseif i <= sum(imgnum2(1:20))
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
        img(y-25+1:y+25,x-25+1:x+25,j)= data2(:,:,i)/255 .* mask(:,:,j);
    end 
end
figure;
imshow(img);
% imwrite(img,'道DMS.png');
LocationVar(-X(:,2),X(:,1),imgnum2,2);

%% 以
k = 1;
for i=imglist3
    a = imgnum3;
    a(imgnum3==0) = [];
    for j=1:a(find(imglist3==i))
        name = [ './以/' num2str(i) '.' num2str(j) '.png'];
        data3(:,:,k) = im2bw(imread(name));
        k = k+1;
    end
end
map3 = zeros(n3,n3);  % 道 SSIM相似度矩阵
for i=1:n3
    for j=1:n3
        if j >= i
            map3(i,j) = 0;
        else
            map3(i,j) = 1-ssim(data3(:,:,i),data3(:,:,j));
        end
    end
end

t3 = zeros(n3,n3);   % 之 不相似度对称矩阵
name3 = string;
for i=1:n3
    for j=1:n3
        if j > i
            % 把下三角矩阵以主对角线为轴复制，变成对称矩阵
            map3(i,j)=map3(j,i);
        end
    end
end
% 给标记点做名字下标
for i=imglist3
    a = imgnum3;
    a(imgnum3==0) = [];
    for j=1:a(find(imglist3==i))
        name3 = [name3 [num2str(i) '.' num2str(j)]];
    end
end
name3(1) = [];
for i=1:n3
    for j=1:n3
        t3(i,j)=-0.5*(map3(i,j)^2 -1/n3*map3(i,:)*map3(i,:)' -1/n3*map3(:,j)'*map3(:,j) +1/n3^2*sum(sum(map3.^2)));
    end
end
[V,D] = eig(t3);
X = V(:,1:2)*D(1:2,1:2).^(1/2);
figure;
for i=1:n3
    if i <= sum(imgnum3(1:1))
        scatter(-X(i,2),X(i,1),[],[174 0 0]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:2))
        scatter(-X(i,2),X(i,1),[],[224 0 4]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:3))
        scatter(-X(i,2),X(i,1),[],[255 77 0]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:4))
        scatter(-X(i,2),X(i,1),[],[255 175 42]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:5))
        scatter(-X(i,2),X(i,1),[],[222 145 18]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:6))
        scatter(-X(i,2),X(i,1),[],[243 234 87]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:7))
        scatter(-X(i,2),X(i,1),[],[154 238 28]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:8))
        scatter(-X(i,2),X(i,1),[],[17 203 10]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:9))
        scatter(-X(i,2),X(i,1),[],[0 127 0]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:10))
        scatter(-X(i,2),X(i,1),[],[34 255 165]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:11))
        scatter(-X(i,2),X(i,1),[],[65 239 255]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:12))
        scatter(-X(i,2),X(i,1),[],[51 213 255]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:13))
        scatter(-X(i,2),X(i,1),[],[38 135 253]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:14))
        scatter(-X(i,2),X(i,1),[],[0 12 238]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:15))
        scatter(-X(i,2),X(i,1),[],[0 85 255]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:16))
        scatter(-X(i,2),X(i,1),[],[0 28 172]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:17))
        scatter(-X(i,2),X(i,1),[],[127 49 255]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:18))
        scatter(-X(i,2),X(i,1),[],[194 161 255]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:19))
        scatter(-X(i,2),X(i,1),[],[103 0 222]/255,'filled');
        hold on
    elseif i <= sum(imgnum3(1:20))
        scatter(-X(i,2),X(i,1),[],[250 165 255]/255,'filled');
        hold on
    else % 21
        scatter(-X(i,2),X(i,1),[],[255 34 221]/255,'filled');
        hold on
    end
end
for i=1:n3
    text(-X(i,2)+0.005,X(i,1)-0.005,name3(i),'FontSize',6,'Interpreter','none');
end
axis([-0.45,0.45,-0.45,0.45]);
title('MDS聚类结果');

% 赋予颜色并绘制
img = zeros(2400,3200,3);
for i=1:n3
    mask = zeros(50,50,3);
    if i <= sum(imgnum3(1:1))
        mask(:,:,1) = 174;
        mask(:,:,2) = 0;
        mask(:,:,3) = 0;
    elseif i <= sum(imgnum3(1:2))
        mask(:,:,1) = 224;
        mask(:,:,2) = 0;
        mask(:,:,3) = 4;
    elseif i <= sum(imgnum3(1:3))
        mask(:,:,1) = 255;
        mask(:,:,2) = 77;
        mask(:,:,3) = 0;
    elseif i <= sum(imgnum3(1:4))
        mask(:,:,1) = 255;
        mask(:,:,2) = 175;
        mask(:,:,3) = 42;
    elseif i <= sum(imgnum3(1:5))
        mask(:,:,1) = 222;
        mask(:,:,2) = 145;
        mask(:,:,3) = 18;
    elseif i <= sum(imgnum3(1:6))
        mask(:,:,1) = 243;
        mask(:,:,2) = 234;
        mask(:,:,3) = 87;
    elseif i <= sum(imgnum3(1:7))
        mask(:,:,1) = 154;
        mask(:,:,2) = 238;
        mask(:,:,3) = 28;
    elseif i <= sum(imgnum3(1:8))
        mask(:,:,1) = 17;
        mask(:,:,2) = 203;
        mask(:,:,3) = 10;
    elseif i <= sum(imgnum3(1:9))
        mask(:,:,1) = 0;
        mask(:,:,2) = 127;
        mask(:,:,3) = 0;
    elseif i <= sum(imgnum3(1:10))
        mask(:,:,1) = 34;
        mask(:,:,2) = 255;
        mask(:,:,3) = 165;
    elseif i <= sum(imgnum3(1:11))
        mask(:,:,1) = 65;
        mask(:,:,2) = 239;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum3(1:12))
        mask(:,:,1) = 51;
        mask(:,:,2) = 213;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum3(1:13))
        mask(:,:,1) = 38;
        mask(:,:,2) = 135;
        mask(:,:,3) = 253;
    elseif i <= sum(imgnum3(1:14))
        mask(:,:,1) = 0;
        mask(:,:,2) = 12;
        mask(:,:,3) = 238;
    elseif i <= sum(imgnum3(1:15))
        mask(:,:,1) = 0;
        mask(:,:,2) = 85;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum3(1:16))
        mask(:,:,1) = 0;
        mask(:,:,2) = 28;
        mask(:,:,3) = 172;
    elseif i <= sum(imgnum3(1:17))
        mask(:,:,1) = 127;
        mask(:,:,2) = 49;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum3(1:18))
        mask(:,:,1) = 194;
        mask(:,:,2) = 161;
        mask(:,:,3) = 255;
    elseif i <= sum(imgnum3(1:19))
        mask(:,:,1) = 103;
        mask(:,:,2) = 0;
        mask(:,:,3) = 222;
    elseif i <= sum(imgnum3(1:20))
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
        img(y-25+1:y+25,x-25+1:x+25,j)= data3(:,:,i)/255 .* mask(:,:,j);
    end 
end
figure;
imshow(img);
% imwrite(img,'以DMS.png');
LocationVar(-X(:,2),X(:,1),imgnum3,3);

%%
function LocationVar(x,y,imgnum,flag)
    n = sum(imgnum);
    Xvar = zeros(1,21);
    Yvar = zeros(1,21);
    Xmean = zeros(1,21);
    Ymean = zeros(1,21);
    Xvar(1) = var(x(1:imgnum(1)));
    Yvar(1) = var(y(1:imgnum(1)));
    Xmean(1) = mean(x(1:imgnum(1)));
    Ymean(1) = mean(y(1:imgnum(1)));
    for i=2:21
        Xvar(i) = var(x(sum(imgnum(1:i-1))+1 : sum(imgnum(1:i))));
        Yvar(i) = var(y(sum(imgnum(1:i-1))+1 : sum(imgnum(1:i))));
        Xmean(i) = mean(x(sum(imgnum(1:i-1))+1 : sum(imgnum(1:i))));
        Ymean(i) = mean(y(sum(imgnum(1:i-1))+1 : sum(imgnum(1:i))));
    end
    figure;
    % plot(1:21,X,1:21,Y);
    data = zeros(21,2);
    data(:,1) = Xvar';
    data(:,2) = -Yvar';
    subplot(1,2,1);
    bar(1:21,data,'stack');
    switch flag
        case 1
            title('不同碑帖的“之”字的DMS结果坐标方差，方差越小说明聚集程度越高');
        case 2
            title('不同碑帖的“道”字的DMS结果坐标方差，方差越小说明聚集程度越高');
        case 3
            title('不同碑帖的“以”字的DMS结果坐标方差，方差越小说明聚集程度越高');
    end
    xticks(1:21);
    legend('X方向坐标','Y方向坐标');
    subplot(1,2,2);
    for i=1:21
        if imgnum(i) ~= 0       
            scatter(Xmean(i),Ymean(i),'b','filled');
            text(Xmean(i)+0.005,Ymean(i)-0.005,num2str(i),'FontSize',6,'Interpreter','none');
            hold on;
        end
    end
    switch flag
        case 1
            title('不同碑帖的“之”字的DMS结果平均坐标位置');
        case 2
            title('不同碑帖的“道”字的DMS结果平均坐标位置');
        case 3
            title('不同碑帖的“以”字的DMS结果平均坐标位置');
    end
end