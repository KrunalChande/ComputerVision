% Write a function to compute X and Y gradients.
clear;

set(0,'DefaultFigureWindowStyle','docked');
figureIndex = 1;
%% Grab images and convert to double
img_simA = imread('Data/simA.jpg');
img_transA = imread('Data/transA.jpg');
figure(figureIndex),clf,set(gcf,'Name','simA image'); figureIndex = figureIndex + 1;
imshow(img_simA);
figure(figureIndex),clf,set(gcf,'Name','transA image'); figureIndex = figureIndex + 1;
imshow(img_transA);
%% SECTION 1 - find XY gradients.
filter = 'sobel';
% filter = 'naive';
windowSize = 15;
sigma = 1;
[ I_x_simA, I_y_simA] = PS4HelperFunctions.findXYGradients( img_simA, windowSize, sigma, filter );
[ I_x_transA, I_y_transA] = PS4HelperFunctions.findXYGradients( img_transA, windowSize, sigma, filter );

% plot figures

figure(figureIndex),clf,set(gcf,'Name','simA xyGradient'); figureIndex = figureIndex + 1;
imshow([I_x_simA I_y_simA]);
figure(figureIndex),clf,set(gcf,'Name','transA xyGradient'); figureIndex = figureIndex + 1;
imshow([I_x_transA I_y_transA]);

%% SECTION 2 - Compute Harris value for each of the images
img = zeros([size(img_transA) 4]);
img(:, :, 1) = img_transA;
img(:, :, 2) = imread('Data/transB.jpg');
img(:, :, 3) = img_simA;
img(:, :, 4) = imread('Data/simB.jpg');
    a = 0.1;
for i  = 1:4
    [ I_x, I_y] = PS4HelperFunctions.findXYGradients( img(:, :, i), windowSize, sigma, filter );
    [Rmax, R] = PS4HelperFunctions.computeHarrisValue(I_x, I_y, a);
    Rmax
    %% SECTION 3
    [posX, posY] = PS4HelperFunctions.doNonMaximalSupression(Rmax, R);
    figure(figureIndex),clf,set(gcf,'Name','Harris Corners'); figureIndex = figureIndex + 1;
    imshow(img(:, :, i),[min(min(img(:, :, i))) max(max(img(:, :, i)))] ); hold on; plot(posX,posY,'g.');
end
