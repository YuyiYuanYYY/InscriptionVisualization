clear; clc; close all;
addpath('./lib');

age1 = 11;   % 前一张碑帖序号
age2 = 12;   % 后一张碑帖序号
origin = double( imread(['./之/之-' num2str(age1) '-堆叠图.png'])) / 255;
target = double( imread(['./之/之-' num2str(age2) '-堆叠图.png'])) / 255;

xlen = 100;
ylen = 100;

% 统一尺寸缩放
origin = gray2img(imresize(origin,[xlen ylen]));
target = gray2img(imresize(target,[xlen ylen]));

% 获取特征点
get_landmarks;

disp("读取图片及获取特征点成功");
%% 图像融合

fps = 30;      % 帧率
duration = 2;  % 秒数
nFrames = duration * fps + 1;

[MergedFaces, WarpedOrigFaces, WarpedDestFaces]...
    = morphFace( origin, target, origPts, destPts, nFrames );

% 逐帧连接成视频
MergedFaces_back = flip( MergedFaces, 4 );
Frames = MergedFaces;
mov = immovie(Frames);
implay(mov);

disp("融合成功");
%% 输出帧和视频

spec = ['./frames/'];
for i = 1:nFrames
%     filepath = sprintf( spec, i );
    filepath = [spec num2str(i) '.png'];
    disp(['写入帧', num2str(i), '到', filepath]);
    imwrite( Frames(:,:,:,i), filepath, 'png' );
end

videopath = ['11-12.avi'];
disp(['写入视频到：', videopath]);
writerObj = VideoWriter(videopath);
open(writerObj);
writeVideo(writerObj,mov);
close(writerObj);

disp("全部完成");

% 把灰度图复制三层，真彩色则不变
function res = gray2img(img)
    if size(img,3) == 3
        res = img;
    else
        res = zeros(size(img,1),size(img,2),3);
        for i=1:3
            res(:,:,i) = img;
        end
    end
end