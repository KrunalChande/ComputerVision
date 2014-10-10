clc;
clear all;
close all;
addpath(pwd);
% addpath('+helperFunctions');

figureIndex = 1;

%% Applying on Original Image

% imgLeft = rgb2gray(im2double(imread('proj2-pair1-L.png')));
% imgRight  = rgb2gray(im2double(imread('proj2-pair1-R.png')));
imgLeft = (im2double(imread('Data/leftTest.png')));
imgRight  = (im2double(imread('Data/rightTest.png')));

figure(figureIndex), clf; set(gcf,'Name','Input Image'); figureIndex = figureIndex + 1;
subplot(1,2,1), imshow(imgLeft);
subplot(1,2,2), imshow(imgRight);

windowSize = 7;

leftDispMap = helperFunctions.normCrossCorr(imgLeft, imgRight, windowSize, 16);
figure(figureIndex), clf; set(gcf,'Name','Left Disparity Map'); figureIndex = figureIndex + 1;
imshow(leftDispMap, [min(min(leftDispMap)) max(max(leftDispMap))]);

rightDispMap = helperFunctions.normCrossCorr(imgRight, imgLeft, windowSize, 16);
figure(figureIndex), clf; set(gcf,'Name','Right Disparity Map'); figureIndex = figureIndex + 1;
imshow(rightDispMap, [min(min(rightDispMap)) max(max(rightDispMap))]);

% %% Adding Gaussian noise
% 
% sigma = .1;
% 
% noise= sigma*randn(size(imgLeft,1),size(imgRight,2));
% 
% imgLeft_withNoise = imgLeft+noise;
% 
% 
% window_size = 7;
% 
% dis_map_left= normcorr(imgLeft_withNoise,imgRight, window_size);
% dis_map_right= normcorr(imgRight,imgLeft_withNoise,window_size);
% 
% %% Increasing contrast
% 
% low_in = min(min(imgLeft));
% high_in = max(max(imgLeft));
% low_out = low_in - 0.2*low_in;
% high_out = high_in + 0.2*high_in;
% if (high_out > 1) 
%     high_out = 1;
% end
% if (low_out < 0) 
%     low_out = 0;
% end
% 
% imgLeft_withContrast =imadjust(imgLeft,[low_in; high_in],[low_out; high_out]); 
% 
% window_size = 5;
% 
% dis_map_left= normcorr(imgLeft_withContrast,imgRight, window_size);
% dis_map_right= normcorr(imgRight,imgLeft_withContrast,window_size);