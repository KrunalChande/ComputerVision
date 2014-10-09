% Implementation of basic stereo algorithm of taking a window around every
% pixel in one image and search for the best match along the same scan line
% in the other image.

%% Load and disp the images
im_l = imread('Data/leftTest.png');
im_r = imread('Data/rightTest.png');
figure(1), clf; set(gcf,'Name','Input Images');
subplot(1,2,1); imshow(im_l);
subplot(1,2,2); imshow(im_r);

%% Part a: Create disparity image D(x,y) s.t. L(x,y) = R(x + D(x,y),y)