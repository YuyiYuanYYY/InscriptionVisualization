% 三角剖面
function [ mask, triangle ] = triangulate( image, points, pretriangle, isDisplay )

if nargin == 4
    triangle = pretriangle;
    
elseif nargin == 3
    isDisplay = false;
    triangle = pretriangle;
    
elseif nargin == 2
    isDisplay = false;
    triangle = delaunay( points(1,:), points(2,:) );
end

[XX, YY] = meshgrid( 1:size(image,2), 1:size(image,1) );
all_x = XX(:);
all_y = YY(:);

mask_1D = zeros(size(image,1)*size(image,2),1);

for i = 1:size(triangle,1)
    in_trig = inpolygon( all_x, all_y,...
        points(1,triangle(i,:)), points(2,triangle(i,:)) );
    mask_1D( in_trig ) = i;
end

mask = reshape(mask_1D, size(image,1), size(image,2));

if isDisplay
    figure;
    imagesc( mask ); 
    axis image; axis off;
    hold on;
    for i = 1:size(triangle,1)
        plot( [points(1, triangle(i,:)) points(1, triangle(i,1))],...
            [points(2, triangle(i,:)) points(2, triangle(i,1))], '-ro');
        hold on;
    end
end

end