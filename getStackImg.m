clc,clear;
% 看你需要哪个字
flag = 3;
switch flag
    % imlist：含有这个字的碑帖序号
    % imgnum：每个碑帖中含有这个字的图片张数，不含有就写0，是个长度为统计碑帖数的行矩阵（之前是1×21）
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
data = zeros(50,50);
k = 1;
% 最终输出的堆叠图图片是只有一层的灰度图
for i=imglist
    a = imgnum;
    a(imgnum==0) = [];
    imgnumNow = a(find(imglist==i));
    for j=1:imgnumNow
        switch flag
            case 1  % 之
                name = [ './之/' num2str(i) '.' num2str(j) '.png'];
            case 2  % 道
                name = [ './道/' num2str(i) '.' num2str(j) '.png'];
            case 3  % 以
                name = [ './以/' num2str(i) '.' num2str(j) '.png'];
        end  
        data = data + im2double(im2bw(imread(name)))/imgnumNow;
        k = k+1;
    end
    switch flag
        case 1  % 之
            imwrite(data,['之-'  num2str(i)  '-堆叠图.png']);
        case 2  % 道
            imwrite(data,['道-'  num2str(i)  '-堆叠图.png']);
        case 3  % 以
            imwrite(data,['以-'  num2str(i)  '-堆叠图.png']);
    end
    data = zeros(50,50);
end