function [ xGradient, yGradient] = findXYGradients( img, windowSize, sigma, filter )
%findXYGradients Finds the xy gradient based on the given method.

if nargin < 2
    filter = 'naive';
    windowSize = 5;
    sigma = 2;
end

% G = fspecial('gaussian',[windowSize windowSize],sigma);
% Ig = imfilter(img,G,'same');
Ig = img;
[rows, cols] = size(Ig);
if strcmp(filter,'naive')
    Ig_padded = padarray(Ig,[1, 1], 'replicate');
    for i = 1:rows
        for j = 1:cols
            yGradient(i,j) = (Ig_padded(i+2,j) - Ig_padded(i,j));
            xGradient(i,j) = (Ig_padded(i,j+2) - Ig_padded(i,j));
        end
    end
end


if strcmp(filter, 'sobel')
    f_x = [-1 0 1;-1 0 1;-1 0 1];
    xGradient = filter2(f_x,Ig);
    f_y = [1 1 1;0 0 0;-1 -1 -1];
    yGradient = filter2(f_y,Ig);
end


end

