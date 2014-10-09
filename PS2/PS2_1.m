% Implementation of basic stereo algorithm of taking a window around every
% pixel in one image and search for the best match along the same scan line
% in the other image.
addpath(pwd);
addpath(strcat(pwd, '/Data'));
figureIndex = 1;
%% Load and disp the images
imgLeft = im2double(imread('Data/leftTest.png'));
imgRight = im2double(imread('Data/rightTest.png'));

figure(figureIndex), clf; set(gcf,'Name','Input Image'); figureIndex = figureIndex + 1;
subplot(1,2,1), imshow(imgLeft);
subplot(1,2,2), imshow(imgRight);

maxDisparity = 4;
windowSize = 3;


%% Part a

leftDispMap = helperFunctions.SSD(imgLeft, imgRight, windowSize, maxDisparity);
figure(figureIndex), clf; set(gcf,'Name','Left Disparity Map'); figureIndex = figureIndex + 1;
imshow(leftDispMap, [min(min(leftDispMap)) max(max(leftDispMap))]);

rightDispMap = helperFunctions.SSD(imgRight, imgLeft, windowSize, maxDisparity);
figure(figureIndex), clf; set(gcf,'Name','Right Disparity Map'); figureIndex = figureIndex + 1;
imshow(rightDispMap, [min(min(rightDispMap)) max(max(rightDispMap))]);

%% Plot as 3D

figure(figureIndex), clf; set(gcf,'Name','Left Disparity Map'); figureIndex = figureIndex + 1;
surf(double(leftDispMap), 'FaceColor', 'interp', 'EdgeColor', 'none', 'FaceLighting', 'phong');


figure(figureIndex), clf; set(gcf,'Name','Right Disparity Map'); figureIndex = figureIndex + 1;
surf(double(rightDispMap), 'FaceColor', 'interp', 'EdgeColor', 'none', 'FaceLighting', 'phong');