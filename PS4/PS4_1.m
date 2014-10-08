% Write a function to compute X and Y gradients.
clear;

set(0,'DefaultFigureWindowStyle','docked');
figureIndex = 5;
%% Grab images and convert to double
img_simA = imread('Data/simA.jpg');
img_simA_normed = im2double(img_simA);
img_transA = imread('Data/transA.jpg');
img_transA_normed = im2double(img_transA);

%% SECTION 1 - find XY gradients.
filter = 'sobel';
windowSize = 15;
sigma = 1;
[ I_x_simA, I_y_simA] = PS4HelperFunctions.findXYGradients( img_simA_normed, windowSize, sigma, filter );
[ I_x_transA, I_y_transA] = PS4HelperFunctions.findXYGradients( img_transA_normed, windowSize, sigma, filter );


% plot figures
figure(figureIndex),clf,set(gcf,'Name','simA image'); figureIndex = figureIndex + 1;
imshow(img_simA);
figure(figureIndex),clf,set(gcf,'Name','simA xyGradient'); figureIndex = figureIndex + 1;
imshow([I_x_simA I_y_simA], [-1 1]);
figure(figureIndex),clf,set(gcf,'Name','transA image'); figureIndex = figureIndex + 1;
imshow(img_transA);
figure(figureIndex),clf,set(gcf,'Name','transA xyGradient'); figureIndex = figureIndex + 1;
imshow([I_x_transA I_y_transA], [-1 1]);

%% SECTION 2 - Compute Harris value for the image

harrisValue = PS4HelperFunctions.computeHarrisValue(I_x_simA, I_y_simA, a);