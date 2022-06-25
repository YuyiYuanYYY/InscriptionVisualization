% 融合人脸

function [MergedFaces, WarpedOrigFaces, WarpedDestFaces]...
    = morphFace( origFace, destFace, origPts, destPts, nFrames )

% origPts, destPts: 两个2×n数组，其列存储[x，y]坐标
MergedFaces = zeros( size(origFace,1), size(origFace,2), size(origFace,3), nFrames );
WarpedOrigFaces = zeros(size(MergedFaces));
WarpedDestFaces = zeros(size(MergedFaces));

% 计算所有帧的三角剖分
[ ~, pretriangle ] = triangulate( origFace, origPts );

for fr = 1:nFrames
    alpha = (fr-1) / (nFrames-1);
    if fr == 2
        wait = 1;
    end
    nowPts = (1-alpha) * origPts + alpha * destPts;
    nowOrig = warpFace( origFace, origPts, nowPts, pretriangle );
    nowDest = warpFace( destFace, destPts, nowPts, pretriangle );
    nowMerged = (1-alpha) * nowOrig + alpha * nowDest;
    
    WarpedOrigFaces(:,:,:,fr) = nowOrig;
    WarpedDestFaces(:,:,:,fr) = nowDest;
    MergedFaces(:,:,:,fr)     = nowMerged; 
end
end