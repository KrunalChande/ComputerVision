addpath(pwd);
addpath(strcat(pwd, '/Data'));
figureIndex = 1;


%% Load and disp the images
imgLeft = im2double(rgb2gray(imread('Data/proj2-pair1-L.png')));
imgRight = im2double(rgb2gray(imread('Data/proj2-pair1-R.png')));

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


if strcmp(selection, 'addNoise')
    imgLeft_toUse = imgLeft_withNoise;
    
elseif strcmp(selection, 'increaseContrast')
    imgLeft_toUse = imgLeft_withContrast;
    
else 
    error('Wrong Choice of selection please choose either `addNoise` or `increaseContrast`');
end

figure(figureIndex), clf; set(gcf,'Name','Input Image'); figureIndex = figureIndex + 1;
subplot(1,2,1), imshow(imgLeft);
subplot(1,2,2), imshow(imgLeft_toUse);

maxDisparity = 64;
windowSize = 5;


%% Part a


leftDispMap = helperFunctions.SSD(imgLeft_toUse, imgRight, windowSize, maxDisparity);
figure(figureIndex), clf; set(gcf,'Name','Left Disparity Map'); figureIndex = figureIndex + 1;
imshow(leftDispMap, [min(min(leftDispMap)) max(max(leftDispMap))]);

rightDispMap = helperFunctions.SSD(imgRight, imgLeft_toUse, windowSize, maxDisparity);
figure(figureIndex), clf; set(gcf,'Name','Right Disparity Map'); figureIndex = figureIndex + 1;
imshow(rightDispMap, [min(min(rightDispMap)) max(max(rightDispMap))]);

%% Part b

figure(figureIndex), clf; set(gcf,'Name','Left Disparity Map'); figureIndex = figureIndex + 1;
surf((leftDispMap), 'FaceColor', 'interp', 'EdgeColor', 'none', 'FaceLighting', 'phong');


figure(figureIndex), clf; set(gcf,'Name','Right Disparity Map'); figureIndex = figureIndex + 1;
surf(double(rightDispMap), 'FaceColor', 'interp', 'EdgeColor', 'none', 'FaceLighting', 'phong');