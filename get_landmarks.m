% 获取特征点

H = ylen;
W = xlen;
origPts = [];
origTXT = load(['./之/', num2str(age1), '.txt']);
% origTXT = load('20.txt');
for i=1:size(origTXT,1)
    origTXT(i,1) = origTXT(i,1) / 50 * W;
    origTXT(i,2) = origTXT(i,2) / 50 * H;
end
% （）
for i=1:size(origTXT,1)
    origPts = [origPts origTXT(i,:)];
end
a = [1,1, 0.25*H,1, 0.5*H,1, 0.75*H,1,...
     H,1, H,0.25*W, H,0.5*W, H,0.75*W,...
     H,W, 0.75*H,W, 0.5*H,W, 0.25*H,W,...
     1,W, 1,0.75*W, 1,0.5*W, 1,0.25*W];
 origPts = [origPts a];
 
destPts = [];
destTXT = load(['./之/', num2str(age2), '.txt']);
% destTXT = load('19.txt');
for i=1:size(destTXT,1)
    destTXT(i,1) = destTXT(i,1) / 50 * W;
    destTXT(i,2) = destTXT(i,2) / 50 * H;
end
for i=1:size(destTXT,1)
    destPts = [destPts destTXT(i,:)];
end
destPts = [destPts a];

origPts = reshape(origPts, 2, []);
destPts = reshape(destPts, 2, []);

