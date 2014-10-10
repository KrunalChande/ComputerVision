clc;
clear;
close all;
addpath(pwd);
% addpath('+helperFunctions');

figureIndex = 1;

%% Applying on Original Image

% imgLeft = rgb2gray(im2double(imread('proj2-pair1-L.png')));
% imgRight  = rgb2gray(im2double(imread('proj2-pair1-R.png')));
imgLeft = (im2double(imread('Data/leftTest.png')));
imgRight  = (im2double(imread('Data/rightTest.png')));

imgLeft = imresize(imgLeft, 0.5, 'nearest');
imgRight = imresize(imgRight, 0.5, 'nearest');
low_in = min(min(imgLeft));
high_in = max(max(imgLeft));
low_out = low_in - 0.2*low_in;
high_out = high_in + 0.2*high_in;
if (high_out > 1) 
    high_out = 1;
end
if (low_out < 0) 
    low_out = 0;
end

imgLeft_withNoise = imnoise(imgLeft,'gaussian',0,0.01);
imgLeft_withContrast =imadjust(imgLeft,[low_in; high_in],[low_out; high_out]); 
imgLeft = imgLeft_withContrast;

figure(figureIndex), clf; set(gcf,'Name','Input Image'); figureIndex = figureIndex + 1;
subplot(1,2,1), imshow(imgLeft);
subplot(1,2,2), imshow(imgRight);

windowSize = 11;

leftDispMap = helperFunctions.normCrossCorr(imgLeft, imgRight, windowSize, 8);
figure(figureIndex), clf; set(gcf,'Name','Left Disparity Map'); figureIndex = figureIndex + 1;
imshow(leftDispMap, [-5 5]);%[min(min(leftDispMap)) max(max(leftDispMap))]);

rightDispMap = helperFunctions.normCrossCorr(imgRight, imgLeft, windowSize, 8);
figure(figureIndex), clf; set(gcf,'Name','Right Disparity Map'); figureIndex = figureIndex + 1;
imshow(rightDispMap, [-5 5]); %[min(min(rightDispMap)) max(max(rightDispMap))]);

figure(figureIndex), clf; set(gcf,'Name','Right Disparity Map'); figureIndex = figureIndex + 1;
surf(double(rightDispMap), 'FaceColor', 'interp', 'EdgeColor', 'none', 'FaceLighting', 'phong');

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