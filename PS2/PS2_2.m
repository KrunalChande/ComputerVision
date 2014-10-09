addpath(pwd);
addpath(strcat(pwd, '/Data'));
figureIndex = 1;
%% Load and disp the images
imgLeft = im2double(rgb2gray(imread('Data/proj2-pair1-L.png')));
imgRight = im2double(rgb2gray(imread('Data/proj2-pair1-R.png')));

figure(figureIndex), clf; set(gcf,'Name','Input Image'); figureIndex = figureIndex + 1;
subplot(1,2,1), imshow(imgLeft);
subplot(1,2,2), imshow(imgRight);

maxDisparity = 64;
windowSize = 5;


%% Part a

leftDispMap = helperFunctions.SSD(imgLeft, imgRight, windowSize, maxDisparity);
figure(figureIndex), clf; set(gcf,'Name','Left Disparity Map'); figureIndex = figureIndex + 1;
imshow(leftDispMap, [min(min(leftDispMap)) max(max(leftDispMap))]);

rightDispMap = helperFunctions.SSD(imgRight, imgLeft, windowSize, maxDisparity);
figure(figureIndex), clf; set(gcf,'Name','Right Disparity Map'); figureIndex = figureIndex + 1;
imshow(rightDispMap, [min(min(rightDispMap)) max(max(rightDispMap))]);

%% Plot as 3D

figure(figureIndex), clf; set(gcf,'Name','Left Disparity Map'); figureIndex = figureIndex + 1;
surf((leftDispMap), 'FaceColor', 'interp', 'EdgeColor', 'none', 'FaceLighting', 'phong');
% 
% 
% figure(figureIndex), clf; set(gcf,'Name','Right Disparity Map'); figureIndex = figureIndex + 1;
% surf(double(rightDispMap), 'FaceColor', 'interp', 'EdgeColor', 'none', 'FaceLighting', 'phong');