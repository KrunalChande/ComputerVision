function [ xGradient, yGradient] = findXYGradients( img, windowSize, sigma, filter )
%findXYGradients Finds the xy gradient based on the given method.

if nargin < 2
    filter = 'naive';
    windowSize = 5;
    sigma = 2;
end

G = fspecial('gaussian',[windowSize windowSize],sigma);
Ig = imfilter(img,G,'same');
[rows, cols] = size(Ig);
if strcmp(filter,'naive')
    Ig_padded = padarray(Ig,[1, 1], 'replicate');
    for i = 1:rows
        for j = 1:cols
            xGradient(i,j) = (Ig_padded(i+2,j) - Ig_padded(i,j));
            yGradient(i,j) = (Ig_padded(i,j+2) - Ig_padded(i,j));
        end
    end
end


if strcmp(filter, 'sobel')
    %%applying sobel edge detector in the horizontal direction
    fx = [-1 0 1;-1 0 1;-1 0 1];
    xGradient = filter2(fx,Ig);
    % applying sobel edge detector in the vertical direction
    fy = [1 1 1;0 0 0;-1 -1 -1];
    yGradient = filter2(fy,Ig);
end


end

